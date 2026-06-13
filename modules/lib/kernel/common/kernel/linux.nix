{ kernel, ... }:
{
  kernel.lib = {
    linux =
      { pkgs }:
      let
        source = pkgs.lib.trivial.importJSON ./packages.json;
      in
      pkgs.fetchurl {
        url = source.linux.url;
        hash = source.linux.hash;
      };

    patched-linux =
      {
        config,
        patches,
        pkgs,
        src,
      }:
      pkgs.stdenv.mkDerivation {
        inherit patches src;
        version = "1.0";
        name = "patched-linux-src";
        nativeBuildInputs = with pkgs; [
          rsync
          perl
        ];
        dontConfigure = true;
        dontBuild = true;

        postPatch = ''
          for dir in arch/*/configs; do
            install -Dm644 "${kernel.lib.prune { inherit config pkgs; }}" "$dir/cachyos_defconfig"
          done
        '';

        installPhase = ''
          mkdir -p "$out"
          rsync -avhP "./" "$out/"
        '';
      };

    std.std-config =
      {
        pkgs,
        hardened ? false,
      }:
      let
        source = pkgs.lib.trivial.importJSON ./packages.json;
      in
      pkgs.fetchFromGitHub {
        owner = source.config.user;
        repo = source.config.repo;
        rev = source.config.rev;
        sha256 = if hardened then source.config.hashHardened else source.config.hash;
        postFetch = ''
          hold="$(mktemp -d)" && conf="$hold/conf"
          cp "$out/linux-cachyos-${if hardened then "hardened" else "lts"}/config" "$conf"
          rm -rfv "$out" && cp -v "$conf" "$out"
        '';
      };
  };
}

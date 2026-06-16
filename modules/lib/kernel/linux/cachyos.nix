{ kernel, ... }:
{
  kernel.linux = {
    cachyos =
      pkgs:
      with (pkgs.lib.trivial.importJSON ./packages.json).linux;
      pkgs.fetchurl { inherit url sha256; };

    kConfig =
      pkgs:
      pkgs.stdenvNoCC.mkDerivation {
        pname = "gen-config";
        version = "custom";

        dontConfigure = true;
        dontPatch = true;
        dontFixup = true;
        dontUnpack = true;

        src =
          with (pkgs.lib.trivial.importJSON ./packages.json).kConfig;
          pkgs.fetchFromGitHub {
            inherit
              repo
              rev
              owner
              sha256
              ;
          };

        buildPhase = ''cp "$src/linux-cachyos-${
          if kernel.lib.params.hardened then "hardened" else "lts"
        }/config" ./config'';
        installPhase = "cp config $out";
      };
  };
}

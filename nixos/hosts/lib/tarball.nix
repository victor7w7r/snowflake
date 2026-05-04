{
  config,
  pkgs,
  additionalContent ? "",
  additionalBuildInputs ? [ ],
}:
let
  closureInfo = pkgs.buildPackages.closureInfo {
    rootPaths = [ config.system.build.toplevel ];
  };
in
{
  system.build.tarball = pkgs.stdenvNoCC.mkDerivation {
    name = "tarball";

    nativeBuildInputs = with pkgs; [ zstd ] ++ additionalBuildInputs;

    buildCommand = ''
      mkdir -p $out
      mkdir -p root/nix/store
      cp ${closureInfo}/registration root/nix/nix-path-registration
      cat ${closureInfo}/store-paths | while read -r path; do
        mkdir -p "root$(dirname "$path")"
        ln -s "$path" "root$path"
      done
      tar -cvh -C root . | zstd -T$NIX_BUILD_CORES > $out/store.tar.zst
      ${if additionalContent != "" then additionalContent else ""}
    '';
  };

  boot.postBootCommands = ''
    set -euo pipefail
    set -x

    REG_FILE="/nix/nix-path-registration"

    ${config.nix.package.out}/bin/nix-store --load-db < "$REG_FILE"
    touch /etc/NIXOS
    ${config.nix.package.out}/bin/nix-env -p /nix/var/nix/profiles/system --set /run/current-system
    rm -f "$REG_FILE"
  '';
}

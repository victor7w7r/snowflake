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

    nativeBuildInputs =
      with pkgs;
      [
        zstd
        rsyncy
      ]
      ++ additionalBuildInputs;

    buildCommand = ''
      mkdir -p $out

      ${if additionalContent != "" then additionalContent else ""}

      mkdir -p root/store

      echo "Copying store files..."
      rsyncy -aHAxr --progress --files-from=${closureInfo}/store-paths / root/

      cp ${closureInfo}/registration root/nix-path-registration

      echo "Compressing with $SIZE..."
      tar -cv -C root . | \
        zstd -T$NIX_BUILD_CORES > $out/store.tar.zst
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

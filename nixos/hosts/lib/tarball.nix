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
        pv
      ]
      ++ additionalBuildInputs;

    buildCommand = ''
      mkdir -p $out
      mkdir -p root/nix/store

      echo "Copying store files and calculating size..."
      xargs -I % cp -a --reflink=auto % -t root/nix/store < ${closureInfo}/store-paths
      cp ${closureInfo}/registration root/nix/nix-path-registration
      SIZE=$(du -sbL root | cut -f1)

      echo "Compressing with $SIZE..."
      tar -ch -C root . | pv -p -e -r -s $SIZE | \
        zstd -T$NIX_BUILD_CORES > $out/store.tar.zst
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

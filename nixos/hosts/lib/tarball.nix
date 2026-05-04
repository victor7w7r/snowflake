{
  config,
  pkgs,
  lib,
  additionalContent ? "",
  additionalBuildInputs ? [ ],
}:
let
  closureInfo = pkgs.buildPackages.closureInfo {
    rootPaths = [ config.system.build.toplevel ];
  };
  storePaths = "$(cat ${closureInfo}/store-paths)";
in
{
  system.build.tarball = pkgs.stdenvNoCC.mkDerivation {
    name = "tarball";

    nativeBuildInputs = with pkgs; [ zstd ] ++ additionalBuildInputs;

    buildCommand = ''
      mkdir -p $out nix/store
      cp ${closureInfo}/registration nix/nix-path-registration
      echo "nix/nix-path-registration" > path_list
      echo "${lib.concatStringsSep "\n" (map (p: lib.removePrefix "/" p) storePaths)}" >> path_list
      tar -cv -C / -T path_list | zstd -T$NIX_BUILD_CORES > $out/store.tar.zst

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

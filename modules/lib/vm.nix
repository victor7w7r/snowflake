{ inputs, ... }:
{
  #nix run ".#vmGeneric"
  perSystem =
    { config, pkgs, ... }:
    {
      packages = {
        vmGeneric = pkgs.writeShellApplication {
          name = "generic-vm";
          text =
            let
              host = inputs.self.nixosConfigurations.generic.config;
            in
            ''
              ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
            '';
        };
      };

      apps = {
        vmGeneric = {
          type = "app";
          program = "${config.packages.vmGeneric}/bin/generic-vm";
        };
      };

    };
}

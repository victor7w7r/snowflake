{ inputs, ... }:
{
  # nix run ".#vm"
  perSystem =
    { config, pkgs, ... }:
    {
      packages = {
        vmGemeric = pkgs.writeShellApplication {
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
        vmGemeric = {
          type = "app";
          program = "${config.packages.vmAlpha}/bin/vm-generic";
        };
      };
    };
}

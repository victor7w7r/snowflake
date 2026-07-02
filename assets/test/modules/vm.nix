{
  den,
  inputs,
  ...
}:
{
  den.aspects.generic.includes = [
    (den.aspects.base { })
    den.aspects.victor7w7r
  ];

  perSystem =
    { config, pkgs, ... }:
    {
      packages = {
        vm = pkgs.writeShellApplication {
          name = "vm";
          text =
            let
              host = inputs.self.nixosConfigurations.generic.config;
            in
            ''
              ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
            '';
        };

        apps = {
          vmGemeric = {
            type = "app";
            program = "${config.packages.vmGeneric}/bin/vm-generic";
          };
        };
      };
    };
}

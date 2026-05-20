# nix run ".#vm"
{ inputs, eg, ... }:
{

  den.aspects.igloo.includes = [
    eg.vm.gui
    # eg.vm.tui
  ];

  perSystem =
    { pkgs, ... }:
    {
      packages.vm = pkgs.writeShellApplication {
        name = "vm";
        text = ''
          ${inputs.self.nixosConfigurations.igloo.config.system.build.vm}/bin/run-igloo-vm "$@"
        '';
      };
    };
}

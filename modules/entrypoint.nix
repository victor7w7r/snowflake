{ den, ... }:
{
  _module.args.__findFile = den.lib.__findFile;

  perSystem =
    { pkgs, ... }:
    {
      packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
    };

  den.default = {
    darwin.system.stateVersion = 6;
    nixos.system.stateVersion = "26.05";
    includes = [
      den.batteries.define-user
      den.batteries.inputs'
      den.batteries.self'
    ];
  };
}

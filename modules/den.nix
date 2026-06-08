{
  den,
  lib,
  inputs,
  ...
}:
{
  imports = [
    (inputs.den.flakeModules.dendritic or { })
    (inputs.flake-file.flakeModules.dendritic or { })
  ];

  _module.args.__findFile = den.lib.__findFile;

  flake-file.inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    flakehub.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";
    den.url = "github:denful/den";
    flake-file.url = "github:vic/flake-file";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.schema = {
    user.classes = lib.mkDefault [ "homeManager" ];
    host.includes = [
      den.batteries.define-user
      den.batteries.inputs'
      den.batteries.self'
    ];
  };
}

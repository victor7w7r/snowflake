{ den, inputs, ... }:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  flake-file.inputs = {
    den.url = "github:denful/den";
    flake-file.url = "github:vic/flake-file";
    disko.url = "github:nix-community/disko";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  _module.args.__findFile = den.lib.__findFile;
}

{
  den,
  inputs,
  __findFile,
  ...
}:
{
  imports = [
    (inputs.den.flakeModules.dendritic or { })
    (inputs.flake-file.flakeModules.dendritic or { })
  ];

  _module.args.__findFile = den.lib.__findFile;

  flake-file.inputs = {
    agenix.url = "github:ryantm/agenix";
    den.url = "github:denful/den";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    flake-file.url = "github:vic/flake-file";
    #https://flakehub.com/flake/NixOS/nixpkgs?view=releases&offset=650 (14)
    nixpkgs.url = "github:NixOS/nixpkgs/3ec636362e1816bc2f0888fa0fa2c69f1bc9e504";
  };

  den.default.includes = [
    den.batteries.inputs'
    den.batteries.self'
    <den/define-user>
    <den/primary-user>
    <den/mutual-provider>
  ];
}

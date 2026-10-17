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
    #nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixpkgs.url = "github:NixOS/nixpkgs/7fd4004d0511991fff3a0524856a9be09e28c5f0";
  };

  den.default.includes = [
    den.batteries.inputs'
    den.batteries.self'
    <den/define-user>
    <den/primary-user>
    <den/mutual-provider>
  ];
}

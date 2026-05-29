{
  den,
  inputs,
  lib,
  ...
}:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  flake-file.inputs = {
    flake-file.url = lib.mkDefault "github:vic/flake-file";
    den.url = lib.mkDefault "github:denful/den";
  };

  _module.args.__findFile = den.lib.__findFile;
}

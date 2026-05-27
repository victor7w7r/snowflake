{ inputs, lib, ... }:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  flake-file.inputs = {
    flake-file.url = lib.mkDefault "github:vic/flake-file";
    den.url = lib.mkDefault "github:denful/den";
  };

  den.schema.user = {
    config.classes = lib.mkDefault [ "homeManager" ];
  };
}

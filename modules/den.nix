{
  den,
  lib,
  inputs,
  ...
}:
{
  _module.args.__findFile = den.lib.__findFile;

  imports = [
    (inputs.den.flakeModules.dendritic or { })
    (inputs.flake-file.flakeModules.dendritic or { })
  ];

  flake-file.inputs = {
    den.url = "github:denful/den";
    flake-file.url = "github:vic/flake-file";
  };

  den = {
    default.includes = with den.batteries; [
      define-user
      inputs'
      self'
    ];
    schema.user.classes = lib.mkDefault [ "homeManager" ];
  };
}

{
  den,
  lib,
  inputs,
  ...
}:
let
  __findFile = den.lib.take.unused __findFile den.lib.__findFile;
in
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
    default.includes = [
      den.batteries.inputs'
      den.batteries.self'
      <den/define-user>
      <den/define-user>
      <den/primary-user>
      <den/mutual-provider>
      (<den/user-shell> "zsh")
    ];
    schema.user.classes = lib.mkDefault [ "homeManager" ];
  };

}

{ lib, ... }:
{
  kernel.lib.concat-config =
    {
      config,
      isString ? false,
    }:
    with lib;
    config
    |> map (structConfig: removeAttrs structConfig [ "__provider" ])
    |> zipAttrsWith (_: builtins.head)
    |> mapAttrsToList (
      option: value: if isString then "${option} ${value}" else "CONFIG_${option}=${value}"
    )
    |> concatStringsSep "\n";
}

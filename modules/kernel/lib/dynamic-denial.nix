{ lib, ... }:
{
  kernel.lib.dynamic-denial =
    {
      config,
      attr,
      excludes ? [ ],
    }:
    with lib;
    config
    |> builtins.readFile
    |> strings.splitString "\n"
    |> builtins.filter (
      line: (lib.hasPrefix "CONFIG_${attr}_" line) || (lib.hasInfix "CONFIG_${attr}_" line)
    )
    |> builtins.concatMap (
      line:
      let
        match = builtins.match ".*CONFIG_(${attr}_[A-Za-z0-9_]+).*" line;
        name = if match != null then builtins.elemAt match 0 else null;
        isExcluded =
          if name != null then builtins.any (ex: lib.strings.hasInfix ex name) excludes else false;
      in
      if match != null && !isExcluded then
        [
          {
            inherit name;
            value = "n";
          }
        ]
      else
        [ ]
    )
    |> builtins.listToAttrs;
}

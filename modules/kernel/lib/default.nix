{ inputs, lib, ... }:
with lib;
{
  imports = [ (inputs.den.namespace "kernel" true) ];

  kernel.lib = {
    dynamic-denial =
      {
        config,
        attr,
        excludes ? [ ],
      }:
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

    concat-config =
      {
        config,
        isString ? false,
      }:
      config
      |> map (structConfig: removeAttrs structConfig [ "__provider" ])
      |> zipAttrsWith (_: builtins.head)
      |> mapAttrsToList (
        option: value: if isString then "${option} ${value}" else "CONFIG_${option}=${value}"
      )
      |> concatStringsSep "\n";

    calc-version = pkgs: src: rec {
      file = pkgs.stdenvNoCC.mkDerivation {
        name = "calc-version";
        inherit src;
        phases = [
          "unpackPhase"
          "installPhase"
        ];
        installPhase = "cp -r Makefile $out";
      };
      majorMinor = lib.versions.majorMinor string;
      extraversionRaw = builtins.match ".*EXTRAVERSION = ([^\n\r]+).*" (builtins.readFile file);
      extraversion =
        if extraversionRaw != null then lib.strings.trim (builtins.head extraversionRaw) else "";
      string = "${
        toString (builtins.match ".+VERSION = ([0-9]+).+" (builtins.readFile file))
        + "."
        + toString (builtins.match ".+PATCHLEVEL = ([0-9]+).+" (builtins.readFile file))
        + "."
        + toString (builtins.match ".+SUBLEVEL = ([0-9]+).+" (builtins.readFile file))
        + (lib.optionalString (extraversion != "") extraversion)
      }";
    };
  };
}

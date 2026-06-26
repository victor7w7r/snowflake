{ inputs, lib, ... }:
{
  imports = [ (inputs.den.namespace "kernel" true) ];

  kernel.lib = {
    concat-config =
      with lib;
      config:
      config
      |> map (structConfig: removeAttrs structConfig [ "__provider" ])
      |> zipAttrsWith (_: builtins.head)
      |> mapAttrsToList (option: value: "CONFIG_${option}=${value}")
      |> concatStringsSep "\n";

    concat-config-str =
      with lib;
      config:
      config
      |> map (attrs: removeAttrs attrs [ "__provider" ])
      |> zipAttrsWith (_: builtins.head)
      |> mapAttrsToList (option: value: "${option} ${value}")
      |> concatStringsSep "\n";

    parse-config =
      with lib;
      config:
      config
      |> builtins.readFile
      |> splitString "\n"
      |> filter (line: line != "" && !(hasPrefix "#" line))
      |> map (
        line:
        let
          parts = splitString "=" line;
          rawName = head parts;
        in
        {
          name = removePrefix "CONFIG_" rawName;
          value = concatStringsSep "=" (tail parts);
        }
      )
      |> listToAttrs;

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

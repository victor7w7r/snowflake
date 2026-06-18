{ lib, ... }:
{
  kernel.lib = {
    concat-config =
      configList:
      lib.pipe configList [
        (map (structConfig: removeAttrs structConfig [ "__provider" ]))
        (lib.zipAttrsWith (_: builtins.head))
        (lib.mapAttrsToList (option: value: "CONFIG_${option}=${value}"))
        (lib.concatStringsSep "\n")
      ];

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

{ lib, inputs, ... }:
{
  imports = [ (inputs.den.namespace "kernel" false) ];

  kernel.lib.version =
    { src }:
    rec {
      file = "${src}/Makefile";
      version = toString (builtins.match ".+VERSION = ([0-9]+).+" (builtins.readFile file));
      patchlevel = toString (builtins.match ".+PATCHLEVEL = ([0-9]+).+" (builtins.readFile file));
      sublevel = toString (builtins.match ".+SUBLEVEL = ([0-9]+).+" (builtins.readFile file));
      extraversionRaw = builtins.match ".*EXTRAVERSION = ([^\n\r]+).*" (builtins.readFile file);
      extraversion =
        if extraversionRaw != null then lib.strings.trim (builtins.head extraversionRaw) else "";
      string = "${
        version + "." + patchlevel + "." + sublevel + (lib.optionalString (extraversion != "") extraversion)
      }";
      majorMinor = lib.versions.majorMinor string;
    };
}

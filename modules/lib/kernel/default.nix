{ lib, inputs, ... }:
{
  imports = [ (inputs.den.namespace "kernel" false) ];

  kernel.lib = {
    functors.app-config =
      configList:
      lib.pipe configList [
        (map (
          structConfig:
          let
            pouch = lib.mapAttrsToList (option: value: ''
              echo "  CONFIG_${option}=${value}"
              sed -i "/^CONFIG_${option}=/d" .config
              echo "CONFIG_${option}=${value}" >> .config
            '') (removeAttrs structConfig [ "__provider" ]);
          in
          pouch
        ))
        lib.flatten
        (lib.concatStringsSep "\n")
      ];

    version =
      { src, stdenv }:
      let
        unpack = stdenv.mkDerivation {
          pname = "unpacked-kernel";
          version = "1.0";
          inherit src;
          installPhase = ''
            mkdir -p $out
            cp -r . $out/
          '';
        };
      in
      rec {
        file = "${unpack}/Makefile";
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
  };
}

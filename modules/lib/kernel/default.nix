{ lib, inputs, ... }:
{
  imports = [ (inputs.den.namespace "kernel" false) ];

  kernel.lib = {
    functors = {
      app-config =
        configList:
        lib.pipe configList [
          (map (
            structConfig:
            lib.mapAttrsToList (option: value: "CONFIG_${option}=${value}") (
              removeAttrs structConfig [ "__provider" ]
            )
          ))
          lib.flatten
          (lib.concatStringsSep "\n")
        ];

      gen-config =
        { pkgs, configContent }:
        pkgs.stdenv.mkDerivation {
          pname = "gen-config";
          version = "custom";

          dontConfigure = true;
          dontPatch = true;
          dontFixup = true;
          dontUnpack = true;

          buildPhase = "cp ${pkgs.writeText "kernel-gen-config" configContent} .config";
          installPhase = "cp .config $out";
        };
    };

    version =
      { src, stdenv }:
      let
        unpack = stdenv.mkDerivation {
          pname = "calculate-version";
          version = "1.0";
          inherit src;
          dontBuild = true;
          installPhase = ''
            mkdir -p $out
            cp -r Makefile $out/
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

{ lib, hosts-attrs, ... }:
{
  den.aspects.sound.provides = lib.genAttrs hosts-attrs.peripheralgui (_: {
    homeManager =
      { pkgs, ... }:
      with pkgs;
      {
        home.packages = [
          calf
          deepfilternet
          lsp-plugins
          libebur128
          #zam-plugins
          zita-convolver
          mda_lv2
          speexdsp
          soundtouch
          rnnoise
        ];
      };
  });
}

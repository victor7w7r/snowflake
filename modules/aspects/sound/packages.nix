{ lib, hosts-attrs, ... }:
{
  den.aspects.sound.provides = lib.genAttrs hosts-attrs.peripheralgui (_: {
    homeManager =
      { pkgs, ... }:
      with pkgs;
      {
        home.packages = [
          #zam-plugins
          alsa-utils
          calf
          deepfilternet
          lsp-plugins
          libebur128
          zita-convolver
          mda_lv2
          speexdsp
          soundtouch
          rnnoise
        ];
      };
  });
}

{ ... }:
{
  den.aspects.sound = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          asak
          kew
          musikcube
          playerctl
          psst
          spotdl
          sptlrx
          youtube-tui
          ytfzf
          ytmdl
          #linuxwave
          #(pkgs.callPackage ./custom/audio-share.nix { })
          #(pkgs.callPackage ./custom/cliwrap.nix { })
          #(pkgs.callPackage ./custom/lyricstify.nix { })
          #(pkgs.callPackage ./custom/gspot.nix { })
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
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

        programs = {
          cava.enable = true;
          ncspot.enable = true;
        };
      };
  };
}

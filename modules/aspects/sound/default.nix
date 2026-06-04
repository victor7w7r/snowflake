{
  den.aspects.sound.default = {
    nixos =
      { pkgs, user, ... }:
      {
        users.groups.audio.members = [ user ];
        environment.systemPackages = with pkgs; [
          asak
          alsa-plugins
          alsa-utils
          alsa-firmware
          alsa-ucm-conf
          kew
          musikcube
          playerctl
          pavucontrol
          pwvucontrol
          helvum
          psst
          sof-firmware
          spotdl
          sptlrx
          youtube-tui
          ytfzf
          ytmdl
          #linuxwave
          #spotify-adblock-git
          #spotify-adkiller-dns-block-git
          #https://github.com/carlocastoldi/blockify
          #https://github.com/trizen/clyrics
          #https://github.com/SathyaBhat/spotify-dl
          #https://github.com/foresterre/imagineer
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

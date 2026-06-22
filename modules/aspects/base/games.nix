{
  den.aspects.base.games = {
    os =
      {
        pkgs,
        isPersistent,
        self',
        ...
      }:
      {
        environment.systemPackages =
          with pkgs;
          [
            asciiquarium-transparent
            cmatrix
            genact
            lavat
            nbsdgames
            neo-cowsay
            pipes-rs
            sl
            ternimal
          ]
          ++ lib.optionals isPersistent [
            aalib
            astroterm
            self'.packages.cementery-escape
            chess-tui
            self'.packages.cli-of-life
            self'.packages.clidle
            cfonts
            self'.packages.go-life
            nbsdgames
            neo
            self'.packages.paclear
            self'.packages.sandscreen
            self'.packages.sxtetris
            terminaltexteffects
            tmatrix
            toilet
            tty-solitaire
          ];
      };

    nixos =
      {
        isPersistent,
        self',
        pkgs,
        ...
      }:
      {
        environment.systemPackages =
          with pkgs;
          lib.optionals isPersistent [
            self'.packages.bollywood
            self'.packages.chalk-animation
            self'.packages.conway-screensaver
            self'.packages.dvdbounce
            self'.packages.dvdts
            self'.packages.fortune-anti-jokes
            self'.packages.fortune-mod-anarchism
            self'.packages.fortune-mod-billwurtz
            self'.packages.fortune-mod-canada-nctr
            self'.packages.fortune-mod-dhammapada
            self'.packages.fortune-mod-g
            self'.packages.fortune-mod-leftism
            self'.packages.gof-rs
            self'.packages.lifecycler
            self'.packages.ncmatrix
            self'.packages.no-more-secrets
            self'.packages.rbonsai
            self'.packages.termsaver
            self'.packages.tuime
            self'.packages.tui-slides
            scope-tui
            cointop
            clock-rs
            ticker
            /*
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-darkknight
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-archlinux
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-bofh-excuses
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-calvin
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-confucius
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-cybersuntzu
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-doctorwho-classic-series
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-doctorwho-new-series
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-es
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-helluva
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-husse
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-issa-haiku
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-matrix
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-limericks
              	  https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-question-answer-jokes
                 https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fortune-mod-yiddish
                 https://github.com/CrystalSplitter/ponysay-modern/blob/master/flake.nix
            */
          ];
      };
  };
}

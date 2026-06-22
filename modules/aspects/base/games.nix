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
            self'.packages.gof-rs
            self'.packages.lifecycler
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
               #https://github.com/poetaman/arttime
               fortune-mod-anarchism fortune-mod-darkknight fortune-mod-dhammapada \
              	fortune-mod-anti-jokes-git fortune-mod-archlinux fortune-mod-billwurtz \
              	fortune-mod-bofh-excuses fortune-mod-calvin fortune-mod-canada-nctr \
              	fortune-mod-confucius fortune-mod-cybersuntzu fortune-mod-doctorwho-classic-series \
              	fortune-mod-doctorwho-new-series fortune-mod-es fortune-mod-futurama \
              	fortune-mod-g-git fortune-mod-helluva fortune-mod-husse \
              	fortune-mod-issa-haiku fortune-mod-leftism-git fortune-mod-limericks \
              	fortune-mod-matrix fortune-mod-mlp fortune-mod-portal-game \
              	fortune-mod-protolol-git fortune-mod-question-answer-jokes fortune-mod-starwars \
              	fortune-mod-sw fortune-mod-vimtips fortune-mod-yiddish fortune-mod-off
               bollywood
            */
          ];
      };
  };
}

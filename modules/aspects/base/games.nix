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
            self'.packages.conway-screensaver
            self'.packages.dvdbounce
            self'.packages.dvdts
            self'.packages.rbonsai
            self'.packages.no-more-secrets
            self'.packages.lifecycler
            scope-tui
            cointop
            clock-rs
            ticker
            /*
                #https://aur.archlinux.org/packages/termsaver-git
                #https://github.com/Chleba/tui-slides
                #https://github.com/tree-s/ncmatrix
                #https://github.com/omagdy7/gof-rs
                #https://github.com/in3rsha/sha256-animation
                #podman run -it docker.io/akiva/bollywood
                #npm i -g chalk-animation
                #https://github.com/poetaman/arttime
                #dra download -a -i maaslalani/pom
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
            */
          ];
      };
  };
}

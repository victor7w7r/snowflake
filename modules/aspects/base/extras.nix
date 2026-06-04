{ lib, ... }:
{
  den.aspects.base.extras = {
    nixos =
      { pkgs, isPersistent, ... }:
      lib.optional isPersistent {
        environment.systemPackages = with pkgs; [
          cheat
          cmd-wrapped
          emptty
          modprobed-db
          glow
          inotify-tools
          jump
          #sampler
          seadrive-fuse
          seafile-shared
          viddy
          vtm
          wtfutil
        ];
        programs.gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
          pinentryPackage = pkgs.pinentry-tty;
        };
      };

    homeManager =
      { isPersistent, ... }:
      lib.optional isPersistent {
        services.pueue.enable = true;
        programs = {
          #lsd.enable = true;
          tealdeer.enable = true;
          bottom.enable = true;
          navi.enable = true;
          hwatch.enable = true;
          topgrade.enable = true;
          asciinema.enable = true;
          rtorrent.enable = true;
        };
      };
  };
}

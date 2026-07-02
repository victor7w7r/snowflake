{ lib, ... }:
{
  den.aspects.base.extras = {
    nixos =
      { isPersistent, pkgs, ... }:
      {
        environment.systemPackages =
          with pkgs;
          lib.optionals isPersistent [
            cheat
            cmd-wrapped
            emptty
            modprobed-db
            glow
            inotify-tools
            jump
            sampler
            seadrive-fuse
            seafile-shared
            viddy
            vtm
            wtfutil
          ];
        programs.gnupg.agent = lib.optionalAttrs isPersistent {
          enable = true;
          enableSSHSupport = true;
          pinentryPackage = pkgs.pinentry-tty;
        };
      };

    provides.to-users.homeManager =
      { isPersistent, ... }:
      lib.optionalAttrs isPersistent {
        services.pueue.enable = true;
        programs = {
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

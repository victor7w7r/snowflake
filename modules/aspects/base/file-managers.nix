{ lib, ... }:
{
  den.aspects.base.file-managers = {
    os =
      { isPersistent, pkgs, ... }:
      lib.optional isPersistent {
        environment.systemPackages = with pkgs; [
          clifm
          lf
          joshuto
          superfile
          termscp
          tran
          trash-cli
          walk
        ];
        programs.yazi = {
          enable = true;
          /*
            settings.manager = {
            show_hidden = true;
            show_symlink = true;
            };
          */
        };
      };

    nixos =
      { isPersistent, pkgs, ... }:
      lib.optional isPersistent {
        environment.systemPackages = with pkgs; [
          fman
          #tuifimanager
          #https://codeberg.org/sylphenix/sff
        ];
      };

    homeManager =
      { isPersistent, ... }:
      lib.optional isPersistent {
        programs = {
          broot.enable = true;
          mc.enable = true;
          nnn.enable = true;
          vifm.enable = true;
          xplr.enable = true;
        };
      };
  };
}

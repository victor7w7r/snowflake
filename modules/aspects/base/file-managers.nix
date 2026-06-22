{ lib, ... }:
{
  den.aspects.base.file-managers = {
    os =
      { isPersistent, pkgs, ... }:
      {
        environment.systemPackages =
          with pkgs;
          lib.optionals isPersistent [
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
      {
        isPersistent,
        self',
        ...
      }:
      {
        environment.systemPackages = lib.optionals isPersistent [
          self'.packages.fman
          self'.packages.tuifimanager
        ];
      };

    homeManager =
      { isPersistent, ... }:
      lib.optionalAttrs isPersistent {
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

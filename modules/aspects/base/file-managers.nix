{ lib, ... }:
{
  den.aspects.base.file-managers = {
    nixos =
      { isLive, pkgs, ... }:
      lib.optional (!isLive) {
        environment.systemPackages = with pkgs; [
          clifm
          lf
          joshuto
          superfile
          termscp
          tran
          trash-cli
          walk
          #tuifimanager
          #https://codeberg.org/sylphenix/sff
          #(pkgs.callPackage ./custom/fman.nix { })
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

    homeManager =
      { isLive, ... }:
      lib.optional (!isLive) {
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

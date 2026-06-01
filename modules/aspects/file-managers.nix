{
  den.aspects.file-managers = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
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

    homeManager.programs = {
      broot.enable = true;
      mc.enable = true;
      nnn.enable = true;
      vifm.enable = true;
      xplr.enable = true;
    };
  };
}

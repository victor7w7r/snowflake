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

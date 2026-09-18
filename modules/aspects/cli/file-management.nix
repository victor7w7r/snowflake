{
  den.aspects.cli.file-management = {
    os =
      { pkgs, ... }:
      {
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
        };
      };

    nixos =
      { pkgs, self', ... }:
      {
        environment.systemPackages =
          with pkgs;
          with self'.packages;
          [
            fman
            tuifimanager
          ];
      };

    provides.to-users.homeManager.programs = {
      broot.enable = true;
      mc.enable = true;
      nnn.enable = true;
      vifm.enable = true;
      xplr.enable = true;
    };
  };
}

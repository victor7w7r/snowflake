{
  system,
  host,
  lib,
  pkgs,
  ...
}:
{
  services = {
    glances.enable = false;
    locate.enable = true;
    envfs.enable = true;
    logrotate.enable = true;
    orca.enable = lib.mkForce false;
    #restic.enable = true;
    dbus = {
      enable = true;
      packages = [
        #nohang
        #uresourced
      ];
    };

    /*
      nohang = {
      enable = true;
      #desktop = true;
      };
    */

    irqbalance.enable = true;
    memavaild.enable = true;
    chrony.enable = true;
    #preload.enable = true;
    prelockd.enable = host != "v7w7r-youyeetoox1";
    resolved.enable = false;
    #uresourced.enable = true;
    scx.enable = system != "aarch64-linux";

  }
  // (
    if host != "v7w7r-opizero2w" then
      {
        ananicy = {
          enable = true;
          package = pkgs.ananicy-cpp;
          rulesProvider = pkgs.ananicy-rules-cachyos;
          extraRules = [
            {
              "name" = "gamescope";
              "nice" = -20;
            }
          ];
        };
      }
    else
      { }
  );
}

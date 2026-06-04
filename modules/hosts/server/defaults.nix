{ inputs, server, ... }:
{
  imports = [ (inputs.den.namespace "server" false) ];

  /*
    nixos-hardware.nixosModules.common-pc-ssd
    nixos-hardware.nixosModules.common-cpu-intel
  */

  den = {
    hosts.x86_64-linux.server = {
      hostName = "v7w7r-youyeetoox1";
      users.victor7w7r = { };
    };

    aspects.server = {
      includes = [
        server.disks-logical
        server.disks-physical
      ];

      nixos =
        { pkgs, user, ... }:
        {

          boot.initrd.services.lvm.enable = true;

          environment.systemPackages = with pkgs; [
            mdadm
            intel-undervolt
          ];

          zramSwap = {
            enable = true;
            algorithm = "zstd";
            memoryPercent = 100;
            priority = 100;
          };

          services = {
            lvm.boot.thin.enable = true;
            rustdesk.enable = true;
          };
        };

      homeManager =
        { user, config, ... }:
        {
          home.file = {
            "shared".source = config.lib.file.mkOutOfStoreSymlink "/run/media/shared";
            "cloud".source = config.lib.file.mkOutOfStoreSymlink "/nix/persist/cloud";
            ".xinitrc".text = ''
              export XAUTHORITY=/home/${user}/.Xauthority
              export XDG_SESSION_TYPE=x11
              export DESKTOP_SESSION=xfce
              exec startxfce4
            '';
          };
        };
    };
  };
}

{ server, ... }:
{
  den = {
    hosts.x86_64-linux.server.users.victor7w7r = { };

    aspects.server = {
      includes = [
        server.disks-logical
        server.disks-physical
      ];

      nixos =
        { pkgs, user, ... }:
        {

          environment.systemPackages = with pkgs; [
            mdadm
            intel-undervolt
          ];

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

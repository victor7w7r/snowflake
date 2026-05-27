{
  den.aspects.system.provides.security.nixos =
    { pkgs, ... }:
    {

      environment.systemPackages = with pkgs; [
        boxxy
        firejail
        hexyl
        luksmeta
        phraze
        veracrypt
      ];

      services = {
        fail2ban.enable = true;
        #opensnitch.enable = true;
        #clamav = {
        #  daemon.enable = true;
        #  updater.enable = true;
        #  scanner.enable = true;
        #};
        #
      };

      security = {
        apparmor = {
          enable = true;
          enableCache = true;
        };
        polkit.enable = true;
        rtkit.enable = true;
        #clamav-gui clamav-unofficial-sigs
        sudo-rs = {
          enable = true;
          package = pkgs.sudo-rs;
          execWheelOnly = true;
          wheelNeedsPassword = false;
          extraRules = [
            {
              users = [ "victor7w7r" ];
              commands = [
                {
                  command = "ALL";
                  options = [
                    "NOPASSWD"
                    "SETENV"
                  ];
                }
                {
                  command = "${pkgs.systemd}/bin/systemctl suspend";
                  options = [ "NOPASSWD" ];
                }
                {
                  command = "${pkgs.systemd}/bin/reboot";
                  options = [ "NOPASSWD" ];
                }
                {
                  command = "${pkgs.systemd}/bin/poweroff";
                  options = [ "NOPASSWD" ];
                }
              ];
            }
          ];
        };
      };
    };
}

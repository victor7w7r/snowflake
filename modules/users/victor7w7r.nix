{ lib, ... }:
{
  den.aspects.victor7w7r = {
    user =
      { pkgs, ... }:
      {
        initialHashedPassword = "$6$rZhNhLxPNJx.lRBn$lXAcMr7CdFgjRcN4ZMlEai2QYWMoawm6pMKrd9oFHXgWks9KBkP3p7Afj/Djj1LnCDyXbLNT5IfVNjDEUzk1p0";
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGTZ3iQqtjrClKVnqQ0w9Yn2sUoE9lAAW8ZYhR45nV5 arkano036@gmail.com"
        ];
      };

    /*
      {
        den.aspects.networking.provides.ssh = {
          user = {
            openssh.authorizedKeys.keys = [
            ];
          };
            // (
              if host == "v7w7r-fajita" then
                {
                  openssh = lib.mkForce {
                    enable = true;
                    settings = {
                      AcceptEnv = null;
                      PermitRootLogin = "yes";
                      PasswordAuthentication = true;
                    };
                  };
                }
              else
                {
                  openssh = lib.mkForce {
                    settings.AcceptEnv = null;
                    enable = true;
                  };
                }
            );

          homeManager = _: {
            programs.ssh = {
              enable = true;
              enableDefaultConfig = false;

              matchBlocks = {
                pi = {
                  hostname = "192.168.0.4";
                  user = "repparw";
                };
              };
            };
          };
        };
      }
    */

    homeManager = {
      home = {
        stateVersion = lib.mkDefault "25.05";
        sessionPath = [ "$HOME/.local/bin" ];
      };
    };
  };
}

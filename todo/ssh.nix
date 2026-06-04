
/*
  {
    den.aspects.networking.provides.ssh = {
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

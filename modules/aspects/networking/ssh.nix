{
  den.aspects.networking.provides.ssh = {
    user = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHGd04EwDYl0a0RAS16wbDI4K2cfHFM8guXXYZdH3XtX u0_a426@localhost #termux"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN6UbXeSlW/2jkIU9mQIN5xWElnFbA9tw0BfT072WXgR t440"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPFzKXBKbNZ+jr06UNKj0MHIzYw54CMP6suD8iTd7CxH ubritos@gmail.com #alpha"
      ];
    };

    /*
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
    */

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

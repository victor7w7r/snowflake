{ lib, ... }:
{
  den.aspects.networking.ssh = {
    nixos =
      { isPhone, isLive, ... }:
      {
        services.openssh = lib.mkForce {
          enable = true;
          settings = {
            AcceptEnv = null;
            PermitRootLogin = lib.optionalAttrs (isPhone || isLive) "yes";
            PasswordAuthentication = true;
          };
        };
      };

    homeManager.programs.ssh = {
      enable = true;
      extraConfig = "Include ~/.ssh/config.d/*";
      enableDefaultConfig = false;
      matchBlocks = {
        "ssh.github.com" = {
          hostname = "ssh.github.com";
          user = "git";
          port = 443;
        };
      };
    };
  };
}

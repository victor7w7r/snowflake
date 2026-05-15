{ lib, ... }:
{
  containers.git = {
    autoStart = true;
    privateNetwork = true;
    enableTun = true;
    ephemeral = false;
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.4";
    extraFlags = [
      "--private-users-ownership=chown"
    ];
    additionalCapabilities = [
      ''all" --system-call-filter="add_key keyctl bpf" --capability="all''
    ];

    bindMounts = {
      "/opt/onedev" = {
        hostPath = "/nix/persist/containers/git";
        isReadOnly = false;
      };
    };

    config =
      { ... }:
      {
        system.stateVersion = "26.05";
        boot.isContainer = true;
        networking = {
          firewall.enable = false;
          useHostResolvConf = lib.mkForce false;
        };
        services = {
          resolved.enable = true;
          journald.extraConfig = "SystemMaxUse=100M";
        };
        systemd.tmpfiles.rules = [ "d /opt/seafile-data 0770 1000 1000 - -" ];

        virtualisation.docker = {
          enable = true;
          autoPrune = {
            enable = true;
            dates = "weekly";
          };
          rootless = {
            enable = false;
            setSocketVariable = true;
          };
        };

        virtualisation.oci-containers.backend = "docker";
        virtualisation.oci-containers.containers.onedev = {
          image = "1dev/server";
          autoStart = true;
          ports = [
            "6610:6610"
            "6611:6611"
          ];
          environment = {
            # initial_server_url = "https://${builtins.toString networkConfig.publicIp}/onedev/";
          };
          extraOptions = [ "--network=host" ];
          volumes = [
            "onedev:/opt/onedev"
            "/var/run/docker.sock:/var/run/docker.sock"
          ];
        };
      };
  };
}

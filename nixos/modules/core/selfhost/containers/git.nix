{ ... }:
{
  containers.git = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.4";
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
      { lib, ... }:
      {
        system.stateVersion = "26.05";
        boot = {
          isContainer = true;
          kernel.sysctl."net.ipv4.ip_forward" = 1;
        };
        networking = {
          firewall.enable = false;
          useHostResolvConf = lib.mkForce false;
          nameservers = [
            "1.1.1.1"
            "8.8.8.8"
          ];
        };

        virtualisation = {
          docker = {
            enable = true;
            daemon.settings = {
              "bridge" = "none";
              "storage-driver" = "overlay2";
              dns = [
                "8.8.8.8"
                "1.1.1.1"
              ];
            };
          };

          oci-containers = {
            backend = "docker";
            containers.onedev = {
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
      };

  };
}

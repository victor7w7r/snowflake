{ ... }:
{
  containers.git = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "brint";
    localAddress = "10.10.0.3/24";
    additionalCapabilities = [
      "CAP_SYS_ADMIN"
      "CAP_NET_ADMIN"
      "CAP_MKNOD"
      "CAP_SYS_CHROOT"
      "CAP_SETGID"
      "CAP_SETUID"
      "CAP_AUDIT_WRITE"
    ];
    forwardPorts = [
      {
        containerPort = 6610;
        hostPort = 6610;
        protocol = "tcp";
      }
      {
        containerPort = 6611;
        hostPort = 6611;
        protocol = "tcp";
      }
    ];
    bindMounts = {
      "/opt/onedev" = {
        hostPath = "/nix/persist/containers/git";
        isReadOnly = false;
      };
    };

    extraFlags = [
      "--system-call-filter=@keyring"
      "--system-call-filter=@memlock"
      "--system-call-filter=bpf"
    ];

    config =
      { lib, ... }:
      {
        system.stateVersion = "26.05";
        boot = {
          isContainer = true;
          kernel.sysctl."net.ipv4.ip_forward" = 1;
        };
        networking = {
          defaultGateway = "10.10.0.1";
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

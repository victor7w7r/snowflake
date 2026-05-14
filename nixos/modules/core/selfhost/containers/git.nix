{ lib, ... }:
{
  containers.git = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.4";
    extraFlags = [
      "--capability=CAP_NET_ADMIN"
      "--capability=CAP_SYS_ADMIN"
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
          nameservers = [
            "1.1.1.1"
            "8.8.8.8"
          ];
        };
        services = {
          resolved.enable = true;
          journald.extraConfig = "SystemMaxUse=100M";
        };
        virtualisation.oci-containers.containers.onedev = {
          image = "docker.io/1dev/server";
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

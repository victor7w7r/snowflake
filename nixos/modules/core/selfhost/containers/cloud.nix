{ config, lib, ... }:
{
  containers.cloud = {
    autoStart = true;
    privateNetwork = true;
    enableTun = true;
    ephemeral = false;
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.2";
    extraFlags = [
      "--private-users-ownership=chown"
    ];
    additionalCapabilities = [
      ''all" --system-call-filter="add_key keyctl bpf" --capability="all''
    ];

    bindMounts = {
      "/opt/seafile-mysql/db" = {
        hostPath = "/nix/persist/cloud/seafile/mysql";
        isReadOnly = false;
      };
      "/etc/seafile-env" = {
        hostPath = config.sops.secrets.seafile-env.path;
        isReadOnly = true;
      };
      "/etc/seafile-db-env" = {
        hostPath = config.sops.secrets.seafile-db-env.path;
        isReadOnly = true;
      };
      "/opt/seafile-data" = {
        hostPath = "/nix/persist/cloud/seafile/shared";
        isReadOnly = false;
      };
    };

    config =
      { pkgs, ... }:
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

        systemd = {
          tmpfiles.rules = [ "d /opt/seafile-data 0770 1000 1000 - -" ];
          services.create-seafile-net = {
            serviceConfig.Type = "oneshot";
            wantedBy = [
              "docker-seafile-mysql.service"
              "docker-seafile.service"
            ];
            script = ''
              check=$(${pkgs.docker}/bin/docker network ls -qf name=seafile-net)
              if [ -z "$check" ]; then
                ${pkgs.docker}/bin/docker network create seafile-net
              fi
            '';
          };
        };

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
        virtualisation.oci-containers.containers = {
          "seafile-mysql" = {
            image = "mariadb:10.11";
            environmentFiles = [ "/etc/seafile-db-env" ];
            volumes = [ "/opt/seafile-mysql/db:/var/lib/mysql" ];
            extraOptions = [ "--network=seafile-net" ];
          };

          "seafile-memcached" = {
            image = "memcached:1.6.18";
            cmd = [
              "memcached"
              "-m"
              "256"
            ];
            extraOptions = [ "--network=seafile-net" ];
          };

          "seafile" = {
            image = "seafileltd/seafile-mc:11.0-latest";
            autoStart = true;
            extraOptions = [
              "--network=seafile-net"
              "--dns=8.8.8.8"
              "--privileged"
            ];
            ports = [ "80:80" ];
            environmentFiles = [ "/etc/seafile-env" ];
            dependsOn = [
              "seafile-mysql"
              "seafile-memcached"
            ];
            volumes = [ "/opt/seafile-data:/shared" ];
          };
        };
      };
  };
}

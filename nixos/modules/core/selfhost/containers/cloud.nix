{ config, lib, ... }:
{
  containers.cloud = {
    autoStart = true;
    privateNetwork = true;
    enableTun = true;
    ephemeral = false;
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.2";
    extraFlags = [ "--private-users-ownership=chown" ];
    additionalCapabilities = [ ''all" --system-call-filter="add_key keyctl bpf" --capability="all'' ];

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
      "/opt/seafile-data/seafile/conf/.env" = {
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
        systemd.tmpfiles.rules = [ "d /opt/seafile-data 0770 1000 1000 - -" ];
        services = {
          resolved.enable = true;
          journald.extraConfig = "SystemMaxUse=100M";
          redis.enable = true;
          mysql = {
            enable = true;
            package = pkgs.mariadb;
            configFile = /etc/seafile-db-env;
            ensureDatabases = [
              "seafile_db"
              "ccnet_db"
              "seahub_db"
            ];
            ensureUsers = [
              {
                name = "seafile";
                ensurePermissions = {
                  "seafile.*" = "ALL PRIVILEGES";
                };
              }
            ];
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
          admin = {
            image = "phpmyadmin";
            extraOptions = [ "--network=host" ];
            ports = [ "8080:80" ];
            environment.PMA_HOST = "127.0.0.1";
          };
          seafile = {
            image = "seafileltd/seafile-mc:13.0-latest";
            extraOptions = [
              "--network=host"
              "--dns=8.8.8.8"
              "--privileged"
            ];
            ports = [ "80:80" ];
            volumes = [ "/opt/seafile-data:/shared" ];
            environmentFiles = [ "/etc/seafile-env" ];
          };
        };
      };
  };
}

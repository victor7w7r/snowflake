{ lib, ... }:
{
  #docker exec -it seafile python3 /scripts/start.py
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
      "/opt/seafile-data" = {
        hostPath = "/nix/persist/cloud/seafile/shared";
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

        systemd.tmpfiles.rules = [
          "d /opt/seafile-data 0770 1000 1000 - -"
        ];

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
            environment = {
              MYSQL_ROOT_PASSWORD = "db_dev";
              MYSQL_LOG_CONSOLE = "true";
              MARIADB_AUTO_UPGRADE = "1";
            };
            volumes = [ "/opt/seafile-mysql/db:/var/lib/mysql" ];
            extraOptions = [ "--network=host" ];
          };

          "seafile-memcached" = {
            image = "memcached:1.6.18";
            cmd = [
              "memcached"
              "-m"
              "256"
            ];
            extraOptions = [ "--network=host" ];
          };

          "seafile" = {
            image = "seafileltd/seafile-mc:11.0-latest";
            autoStart = true;
            extraOptions = [
              "--network=host"
              "--privileged"
            ];
            ports = [ "80:80" ];
            environment = {
              DB_HOST = "seafile-mysql";
              DB_ROOT_PASSWD = "db_dev";
              TIME_ZONE = "America/Guayaquil";
              SEAFILE_ADMIN_EMAIL = "arkano036@gmail.com";
              SEAFILE_ADMIN_PASSWORD = "asecret";
              #SEAFILE_SERVER_HOSTNAME
              #SEAFILE_SERVER_LETSENCRYPT
            };
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

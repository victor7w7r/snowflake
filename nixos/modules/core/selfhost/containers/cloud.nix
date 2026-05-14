{ ... }:
{
  #docker exec -it seafile python3 /scripts/start.py
  #systemctl restart docker-seafile.service
  containers.cloud = {
    autoStart = true;
    privateNetwork = true;
    enableTun = true;
    ephemeral = false;
    hostBridge = "brint";
    localAddress = "10.10.0.2/24";
    additionalCapabilities = [
      ''all" --system-call-filter="add_key keyctl bpf" --capability="all''
    ];
    forwardPorts = [
      {
        containerPort = 80;
        hostPort = 80;
        protocol = "tcp";
      }
    ];
    extraFlags = [
      "--capability=CAP_NET_ADMIN"
      "--capability=CAP_SYS_ADMIN"
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
      { pkgs, lib, ... }:
      {
        system.stateVersion = "26.05";
        boot.isContainer = true;
        environment.systemPackages = with pkgs; [
          netcat
          tcpdump
          nmap
          arp-scan
        ];
        networking = {
          firewall.enable = false;
          useHostResolvConf = lib.mkForce false;
        };
        services.resolved.enable = true;
        systemd.tmpfiles.rules = [
          "d /opt/seafile-data 0770 1000 1000 - -"
        ];

        virtualisation.podman = {
          enable = true;
          defaultNetwork.settings.dns_enabled = true;
        };

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
            extraOptions = [
              "--network=host"
            ];
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

{ ... }:
{
  #docker exec -it seafile python3 /scripts/start.py
  #systemctl restart docker-seafile.service
  containers.cloud = {
    autoStart = true;
    privateNetwork = true;
    enableTun = true;
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

    extraFlags = [
      "--system-call-filter=@keyring"
      "--system-call-filter=@memlock"
      "--system-call-filter=bpf"
    ];

    config =
      { pkgs, lib, ... }:
      {
        system.stateVersion = "26.05";
        boot = {
          isContainer = true;
          kernel.sysctl."net.ipv4.ip_forward" = 1;
        };
        environment.systemPackages = with pkgs; [
          netcat
          tcpdump
          nmap
          arp-scan
        ];
        networking = {
          defaultGateway = "10.10.0.1";
          firewall.enable = false;
          useHostResolvConf = lib.mkForce false;
          nameservers = [
            "1.1.1.1"
            "8.8.8.8"
          ];
        };
        services.resolved.enable = true;
        systemd = {
          tmpfiles.rules = [
            "d /opt/seafile-data 0770 1000 1000 - -"
          ];
          /*
            services.docker.path = [ pkgs.fuse-overlayfs ];
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
          */
        };
        virtualisation.oci-containers.containers = {
          "seafile-mysql" = {
            image = "mariadb:10.11";
            environment = {
              MYSQL_ROOT_PASSWORD = "db_dev";
              MYSQL_LOG_CONSOLE = "true";
              MARIADB_AUTO_UPGRADE = "1";
            };
            volumes = [
              "/opt/seafile-mysql/db:/var/lib/mysql"
            ];
            extraOptions = [
              "--network=host"
            ];
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
        /*
          docker = {
            enable = true;
            autoPrune.enable = true;
            rootless = {
              enable = true;
              setSocketVariable = true;
            };
              daemon.settings = {
              "bridge" = "none";
              "iptables" = false;
              "storage-driver" = "overlay2";
              dns = [
                "8.8.8.8"
                "1.1.1.1"
              ];
              };
        */
      };
  };
}

{ lib, ... }:
{
  containers.notes = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.3";
    extraFlags = [
      "--capability=CAP_NET_ADMIN"
      "--capability=CAP_SYS_ADMIN"
    ];
    additionalCapabilities = [
      ''all" --system-call-filter="add_key keyctl bpf" --capability="all''
    ];
    bindMounts = {
      "/opt/couchdb/data" = {
        hostPath = "/nix/persist/containers/notes/data";
        isReadOnly = false;
      };
      "/web/vaults" = {
        hostPath = "/nix/persist/containers/notes/web/vaults";
        isReadOnly = false;
      };
      "/web/config" = {
        hostPath = "/nix/persist/containers/notes/web/config";
        isReadOnly = false;
      };
      "/run/secrets/rendered/couchdb-admins.ini" = {
        hostPath = "/run/secrets/rendered/couchdb-admins.ini";
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
          couchdb = {
            enable = true;
            bindAddress = "0.0.0.0";
            extraConfig = {
              couchdb = {
                single_node = true;
                max_http_request_size = 4294967296;
                max_document_size = 50000000;
              };

              chttpd = {
                require_valid_user = true;
                max_http_request_size = 4294967296;
                enable_cors = true;
              };

              chttpd_auth = {
                require_valid_user = true;
                authentication_redirect = "/_utils/session.html";
              };

              httpd = {
                WWW-Authenticate = ''Basic realm="couchdb"'';
                enable_cors = true;
                bind_address = "0.0.0.0";
              };

              cors = {
                origins = "app://obsidian.md, capacitor://localhost, http://localhost";
                credentials = true;
                headers = "accept, authorization, content-type, origin, referer";
                methods = "GET,PUT,POST,HEAD,DELETE";
                max_age = 3600;
              };

            };
            extraConfigFiles = [ "/run/secrets/couchdb-admins.ini" ];
          };
        };

        systemd.tmpfiles.rules = [
          "d /opt/couchdb/data 0770 couchdb couchdb - -"
          "d /opt/couchdb/etc/local.d 0770 couchdb couchdb - -"
          "d /run/secrets/couchdb-admins.ini 0770 couchdb couchdb - -"
          "d /web/vaults 0770 couchdb couchdb - -"
          "d /web/config 0770 couchdb couchdb - -"
        ];

        virtualisation.oci-containers.containers."obsidian-web" = {
          image = "docker.io/sytone/obsidian-remote:latest";
          autoStart = true;
          extraOptions = [ "--network=host" ];
          environment = { };
          volumes = [
            "/web/vaults:/vaults"
            "/web/config:/config"
          ];
        };
      };
  };
}

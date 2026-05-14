{ config, ... }:
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;

    virtualHosts = {
      "funnel" = {
        serverName = config.sops.placeholder.tunnel;
        addSSL = false;
        forceSSL = false;
        listen = [
          {
            addr = "0.0.0.0";
            port = 8080;
          }
        ];
        locations = {
          "/" = {
            proxyPass = "https://127.0.0.1:8006";
          };
          "/pc" = {
            proxyPass = "http://127.0.0.1:9090";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;

              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";

              proxy_buffering off;
            '';
          };
          "/chat" = {
            proxyPass = "http://192.168.100.5:8080";
          };
        };
      };

      "funnel-2" = {
        serverName = config.sops.placeholder.tunnel;
        addSSL = false;
        forceSSL = false;
        listen = [
          {
            addr = "0.0.0.0";
            port = 8081;
          }
        ];
        locations = {
          "/" = {
            proxyPass = "http://192.168.100.2:80";
          };
          "/git" = {
            proxyPass = "http://192.168.100.4:6610";
          };
          "/ssh" = {
            proxyPass = "http://192.168.100.4:6611";
          };
        };
      };

      "funnel-3" = {
        serverName = config.sops.placeholder.tunnel;
        addSSL = false;
        forceSSL = false;
        listen = [
          {
            addr = "0.0.0.0";
            port = 8082;
          }
        ];
        locations = {
          "/" = {
            proxyPass = "http://192.168.100.3:8080";
          };
          "/db" = {
            #TCP TUNNEL
            proxyPass = "http://192.168.100.3:5984";
          };
          "/mc" = {
            #TCP TUNNEL
            proxyPass = "http://192.168.100.6:25565";
          };
        };
      };
    };
  };
}

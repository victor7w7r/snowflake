{ containers, ... }: {
  den.aspects.server.containers.nixos = {
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

    containers.notes = containers.lib.call {
      ip = "3";
      name = "notes";

      forwardPorts = [
        {
          containerPort = 80;
          hostPort = 80;
          protocol = "tcp";
        }
        {
          containerPort = 443;
          hostPort = 443;
          protocol = "tcp";
        }
      ];

      bindMounts = {
        "/docker/nginx" = {
          hostPath = "/nix/persist/containers/notes/nginx";
          isReadOnly = false;
        };
      };

      secrets.appflowy-env.file = ../secrets/appflowy-env.age;

      systemd = config: pkgs: {
        init-appflowy = {
          description = "Startup Appflowy";
          after = [
            "network.target"
            "docker.service"
          ];
          wantedBy = [ "multi-user.target" ];
          script = ''
            mkdir -p /opt && cd /opt
            if [ ! -d "appflowy" ]; then
             ${pkgs.git}/bin/git -C appflowy clone https://github.com/AppFlowy-IO/AppFlowy-SelfHost-Commercial 
            fi
            cd appflowy
            cp ${config.age.secrets.appflowy-env.path} .env
            ${pkgs.docker-compose}/bin/docker-compose up -d
          '';
        };
        funnel = containers.lib.funnel {
          inherit pkgs;
          incoming = "80";
          outgoingTcp = "443";
        };
      };
    };
  };
}

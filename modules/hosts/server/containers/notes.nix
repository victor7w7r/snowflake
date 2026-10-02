{ containers, ... }: {
  den.aspects.server.containers.nixos = {
    networking.firewall.allowedTCPPorts = [ 6806 ];

    containers.notes = containers.lib.call {
      ip = "3";
      name = "notes";

      forwardPorts = [
        {
          containerPort = 6806;
          hostPort = 6806;
          protocol = "tcp";
        }
      ];

      bindMounts = {
        "/var/lib/siyuan" = {
          hostPath = "/nix/persist/containers/notes/data";
          isReadOnly = false;
        };
      };

      #secrets.appflowy-env.file = ../secrets/appflowy-env.age;

      rules = [ "d /var/lib/siyuan 0755 1000 1000 -" ];

      systemd = _: pkgs: {
        funnel = containers.lib.funnel {
          inherit pkgs;
          incoming = "6806";
        };
      };

      containers = _: {
        siyuan = {
          image = "b3log/siyuan:latest";
          autoStart = true;
          ports = [ "6806:6806" ];
          environment = {
            TZ = "America/Guayaquil";
            SIYUAN_ACCESS_AUTH_CODE_BYPASS = "true";
            PUID = "1000";
            PGID = "1000";
            SIYUAN_LANG = "es";
          };
          exec = [
            "serve"
            "--workspace=/data"
          ];
          volumes = [ "/var/lib/siyuan:/data" ];
        };
      };
    };
  };
}

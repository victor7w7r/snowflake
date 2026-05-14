{ ... }:
{
  containers.cp = {
    autoStart = false;
    privateNetwork = true;
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.7";
    additionalCapabilities = [
      ''all" --system-call-filter="add_key keyctl bpf" --capability="all''
    ];
    bindMounts = {
      "/opt/wand/houdini" = {
        hostPath = "/nix/persist/containers/wand/houdini";
        isReadOnly = false;
      };
      "/opt/wand/.data" = {
        hostPath = "/nix/persist/containers/wand/data";
        isReadOnly = false;
      };
    };

    config =
      { pkgs, lib, ... }:
      {
        system.stateVersion = "26.05";
        boot.isContainer = true;
        networking = {
          defaultGateway = "10.10.0.1";
          useHostResolvConf = lib.mkForce false;
          nameservers = [
            "1.1.1.1"
            "8.8.8.8"
          ];
          firewall.enable = false;
        };

        environment.systemPackages = with pkgs; [
          git
          docker-compose
        ];

        systemd.services.init-wand = {
          description = "Startup Wand";
          after = [
            "network.target"
            "docker.service"
          ];
          wantedBy = [ "multi-user.target" ];

          script = ''
                        mkdir -p /opt
                        cd /opt
                        if [ ! -d "wand" ]; then
                          ${pkgs.git}/bin/git clone --recurse-submodules https://github.com/solero/wand
                          rm -rf wand/.env
                        fi
                        cd wand
                        if [ ! -f ".env" ]; then
                            cat <<EOF > .env
            POSTGRES_USER=postgres
            POSTGRES_PASSWORD=postgres
            WEB_PORT=80
            WEB_HOSTNAME=localhost
            WEB_LEGACY_PLAY=http://old.localhost
            WEB_LEGACY_MEDIA=http://legacy.localhost
            WEB_VANILLA_PLAY=http://play.localhost
            WEB_VANILLA_MEDIA=http://media.localhost
            WEB_RECAPTCHA_SITE=
            WEB_RECAPTCHA_SECRET=

            EMAIL_METHOD=
            EMAIL_FROM_ADDRESS=no-reply@example.com
            EMAIL_SENDGRID_KEY=
            EMAIL_SMTP_HOST=
            EMAIL_SMTP_PORT=
            EMAIL_SMTP_USER=
            EMAIL_SMTP_PASS=
            EMAIL_SMTP_SSL=TRUE

            GAME_ADDRESS=127.0.0.1
            GAME_LOGIN_PORT=6112

            SNOWFLAKE_HOST=127.0.0.1
            SNOWFLAKE_PORT=7002
            APPLY_WINDOWMANAGER_OFFSET=False
            ALLOW_FORCESTART_SNOW=False
            ALLOW_FORCESTART_TUSK=True
            MATCHMAKING_TIMEOUT=30
            EOF
                        fi
                        ${pkgs.docker-compose}/bin/docker-compose up -d
          '';
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };
        };

        virtualisation = {
          docker = {
            enable = true;
            daemon.settings = {
              "bridge" = "none";
              "storage-driver" = "overlay2";
              dns = [
                "8.8.8.8"
                "1.1.1.1"
              ];
            };
          };
        };
      };
  };
}

{ pkgs, ... }: {
  environment = {
    pathsToLink = [ "/share/alsa/ucm2" ];
    variables.ALSA_CONFIG_UCM2 = "/run/current-system/sw/share/alsa/ucm2";
    systemPackages = [
      pkgs.alsa-ucm-conf
      (pkgs.runCommand "sdm845-alsa-ucm"
        {
          src = pkgs.fetchFromGitLab {
            name = "sdm845-alsa-ucm";
            owner = "sdm845-mainline";
            repo = "alsa-ucm-conf";
            rev = "1b8d290e5aa2ca16b7f2fa8d74910ad19ef88b3a";
            sha256 = "sha256-Kg4vxDrli/ffNeUwDBL5GfdJsbwFRPAUieQEsjVKADw=";
          };
          postPatch = "";
        }
        ''
          mkdir -p $out/share
          ln -s $src $out/share/alsa
        ''
      )
    ];
  };

  services.pipewire.wireplumber.extraConfig.alsa-config-xxx."monitor.alsa.rules" = [
    {
      matches = [
        { "node.name" = "~alsa_input.*"; }
        { "node.name" = "~alsa_output.*"; }
      ];
      actions.update-props = {
        "audio.format" = "S16LE";
        "audio.rate" = 48000;
        "api.alsa.period-size" = 4096;
        "api.alsa.period-num" = 6;
        "api.alsa.headroom" = 512;
      };
    }
  ];

  systemd = {
    user.services = {
      pipewire.environment.ALSA_CONFIG_UCM2 = "/run/current-system/sw/share/alsa/ucm2";
      pipewire-pulse.environment.ALSA_CONFIG_UCM2 = "/run/current-system/sw/share/alsa/ucm2";
      wireplumber.environment.ALSA_CONFIG_UCM2 = "/run/current-system/sw/share/alsa/ucm2";
    };
    services = {
      pipewire.environment.ALSA_CONFIG_UCM2 = "/run/current-system/sw/share/alsa/ucm2";
      pipewire-pulse.environment.ALSA_CONFIG_UCM2 = "/run/current-system/sw/share/alsa/ucm2";
      wireplumber.environment.ALSA_CONFIG_UCM2 = "/run/current-system/sw/share/alsa/ucm2";
    };
  };
}

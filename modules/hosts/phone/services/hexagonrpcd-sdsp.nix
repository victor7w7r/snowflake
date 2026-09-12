{ inputs, ... }: {
  den.aspects.phone.services.hexagonrpcd-sdsp.nixos = { pkgs, ... }: {
    systemd.services.hexagonrpcd-sdsp = {
      description = "Hexagonrpcd SDSP";
      wantedBy = [ "multi-user.target" ];
      unitConfig.ConditionPathExists = [ "/dev/fastrpc-sdsp" ];
      serviceConfig = {
        Restart = "always";
        RestartSec = 3;
      };
      script = ''
        ${pkgs.hexagonrpc}/bin/hexagonrpcd -R "${inputs.oneplus}/usr/share/qcom/sdm845/OnePlus/oneplus6" -d sdsp -f /dev/fastrpc-sdsp -s
      '';
    };
  };
}

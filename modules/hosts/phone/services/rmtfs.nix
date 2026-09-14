{
  den.aspects.phone.services.rmtfs.nixos =
    { pkgs, ... }:
    pkgs.rmtfs.overrideAttrs (oldAttrs: {
      postPatch = (oldAttrs.postPatch or "") + ''
        substituteInPlace storage.c \
          --replace-fail '"/boot/modem_fs1"' '"/efs/modem_fs1"' \
          --replace-fail '"/boot/modem_fs2"' '"/efs/modem_fs2"' \
          --replace-fail '"/boot/modem_fsc"' '"/efs/modem_fsc"' \
          --replace-fail '"/boot/modem_fsg"' '"/efs/modem_fsg"' \
          --replace-fail '"/boot/modem_study"' '"/efs/modem_study"' \
          --replace-fail '"/boot/modem_tunning"' '"/efs/modem_tunning"' \
          --replace-fail '"/boot/modem_tng"' '"/efs/modem_tng"'
      '';
    })
    |> (rmtfs: {
      environment.systemPackages = [ rmtfs ];

      systemd.services.rmtfs = {
        description = "Qualcomm Remote Filesystem Daemon (rmtfs)";
        wantedBy = [ "multi-user.target" ];
        before = [ "network.target" ];

        serviceConfig = {
          ExecStart = "${rmtfs}/bin/rmtfs -r -P -s";
          Restart = "on-failure";
          RestartSec = "2s";
          User = "root";
          Group = "root";
        };
      };
    });
}

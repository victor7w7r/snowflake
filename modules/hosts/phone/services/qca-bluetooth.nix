{
  den.aspects.phone.services.qca-bluetooth.nixos =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      systemd.services.qca-bluetooth = {
        description = "Setup the bluetooth interface";
        wantedBy = [
          "multi-user.target"
          "bluetooth.service"
        ];
        script = toString (
          pkgs.writeShellScript "qca-bluetooth.sh" ''
            set -x
            trap 'sleep 1' DEBUG
            export PATH="${
              lib.makeBinPath (
                with pkgs;
                [
                  config.hardware.bluetooth.package
                  coreutils-full
                  gawk
                  unixtools.script
                ]
              )
            }:$PATH"

            SERIAL=$(grep -o "serialno.*" /proc/cmdline | cut -d" " -f1)
            BT_MAC=$(echo "$SERIAL-BT" | sha256sum | awk -v prefix=0200 '{printf("%s%010s\n", prefix, $1)}')
            BT_MAC=$(echo "$BT_MAC" | cut -c1-12 | sed 's/\(..\)/\1:/g' | sed '$s/:$//')

            script -qc "btmgmt --timeout 3 -i hci0 power off"
            script -qc "btmgmt --timeout 3 -i hci0 public-addr \"$BT_MAC\""
          ''
        );
        serviceConfig = {
          User = "root";
          Type = "oneshot";
          RemainAfterExit = true;
        };
      };
    };
}

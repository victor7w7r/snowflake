{
  den.aspects.phone.services.msm-modem-uim-selection.nixos = { pkgs, ... }: {
    systemd.services.msm-modem-uim-selection = {
      enable = true;
      before = [ "ModemManager.service" ];
      wantedBy = [ "ModemManager.service" ];

      path = with pkgs; [
        libqmi
        gawk
        gnugrep
      ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        set -eu

        SIM_WAIT_TIME=4
        QMICLI_MODEM=

        count=0
        while [ -z "$QMICLI_MODEM" ] && [ "$count" -lt "45" ]
        do
          if qmicli --silent -pd qrtr://0 --uim-noop > /dev/null
          then
            QMICLI_MODEM="qmicli --silent -pd qrtr://0"
            echo "Using qrtr://0"
          fi
          sleep 1
          count=$((count+1))
        done
        echo "Waited $count seconds for modem device to appear"

        if [ -z "$QMICLI_MODEM" ]
        then
          echo 'No modem available.'
          exit 2
        fi

        QMI_CARDS=$($QMICLI_MODEM --uim-get-card-status)

        count=0
        while ! printf "%s" "$QMI_CARDS" | grep -Fq "Card state: 'present'"
        do
          if [ "$count" -ge "$SIM_WAIT_TIME" ]
          then
            echo "No sim detected after $SIM_WAIT_TIME seconds."
            exit 0
          fi

          sleep 1
          count=$((count+1))
          QMI_CARDS=$($QMICLI_MODEM --uim-get-card-status)
        done
        echo "Waited $count seconds for modem to come up"

        if ! printf "%s" "$QMI_CARDS" | grep -Fq "Primary GW:   session doesn't exist"
        then
          echo 'Application was already selected.'
          $QMICLI_MODEM --uim-change-provisioning-session='activate=no,session-type=primary-gw-provisioning' > /dev/null
        fi

        FIRST_PRESENT_SLOT=$(printf "%s" "$QMI_CARDS" | grep "Card state: 'present'" -m1 -B1 | head -n1 | cut -c7-7)
        FIRST_PRESENT_AID=$(printf "%s" "$QMI_CARDS" | grep "usim (2)" -m1 -A3 | tail -n1 | awk '{print $1}')

        if [ -z "$FIRST_PRESENT_AID" ]; then
          echo "No usim application found."
          exit 0
        fi

        echo "Selecting $FIRST_PRESENT_AID on slot $FIRST_PRESENT_SLOT"

        $QMICLI_MODEM --uim-change-provisioning-session="slot=$FIRST_PRESENT_SLOT,activate=yes,session-type=primary-gw-provisioning,aid=$FIRST_PRESENT_AID" > /dev/null

        exit $?
      '';
    };
  };
}

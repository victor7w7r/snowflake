{ lib, ... }:
{
  den.aspects.tweaks.udev.nixos =
    {
      isGeneric,
      isIntel,
      isVisual,
      pkgs,
      ...
    }:
    let
      power-script =
        let
          policyFile = "/sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference";
          hwpFile = "/sys/devices/system/cpu/cpufreq/policy*/hwp_dynamic_boost";
        in
        pkgs.writeShellScript "power-script" ''
           STATE=$(cat /sys/class/power_supply/AC*/online 2>/dev/null || echo 1)

           if [ "$STATE" = "1" ]; then
             echo "power" > ${policyFile}
             echo "1" > ${hwpFile}
             ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance
           else
          echo "power" > ${policyFile}
             echo 0 > ${hwpFile}
             ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
           fi
        '';
    in
    {
      services.udev.extraRules = ''
        ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
          ATTR{queue/scheduler}="none"

        ${lib.optionalString isVisual ''
          KERNEL=="rtc0", GROUP="audio"
          KERNEL=="hpet", GROUP="audio"
          DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
        ''}

        ${lib.optionalString isGeneric ''SUBSYSTEM=="power_supply", ACTION=="change", RUN+="${power-script}"''}

        ${lib.optionalString isIntel ''
          ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
          ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", \
            ATTR{queue/scheduler}="mq-deadline"
          ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", \
            ATTRS{id/bus}=="ata", RUN+="${pkgs.hdparm}/bin/hdparm -B 254 -S 0 /dev/%k"
          ACTION=="add", SUBSYSTEM=="sound", KERNEL=="card*", DRIVERS=="snd_hda_intel", TEST!="/run/udev/snd-hda-intel-powersave", \
            RUN+="${pkgs.bash}/bin/bash -c 'touch /run/udev/snd-hda-intel-powersave; \
            [[ $$(cat /sys/class/power_supply/BAT0/status 2>/dev/null) != \"Discharging\" ]] && \
            echo $$(cat /sys/module/snd_hda_intel/parameters/power_save) > /run/udev/snd-hda-intel-powersave && \
            echo 0 > /sys/module/snd_hda_intel/parameters/power_save'"
          SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", TEST=="/sys/module/snd_hda_intel", \
            RUN+="${pkgs.bash}/bin/bash -c 'echo $$(cat /run/udev/snd-hda-intel-powersave 2>/dev/null || \
            echo 10) > /sys/module/snd_hda_intel/parameters/power_save'"
          SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", TEST=="/sys/module/snd_hda_intel", \
            RUN+="${pkgs.bash}/bin/bash -c '[[ $$(cat /sys/module/snd_hda_intel/parameters/power_save) != 0 ]] && \
            echo $$(cat /sys/module/snd_hda_intel/parameters/power_save) > /run/udev/snd-hda-intel-powersave; \
            echo 0 > /sys/module/snd_hda_intel/parameters/power_save'"
        ''}
      '';
    };
}

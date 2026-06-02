{
  pkgs,
  lib,
  host,
  system,
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
  services = {
    fwupd.enable = host != "v7w7r-macmini81" && host != "v7w7r-nixvm";
    #lact.enable = true;
    #upower.enable = lib.mkDefault host != "v7w7r-youyeetoox1" && host != "v7w7r-macmini81";
    thermald.enable = host != "v7w7r-vm" && host != "v7w7r-rc71l" && system != "aarch64-linux";
    udev.extraRules = ''
      SUBSYSTEM=="power_supply", ACTION=="change", RUN+="${power-script}"
    '';
  };

  systemd.services = {
    /*
      systemd.sleep.settings.Sleep = {
        HibernateDelaySec = "1h";
        SuspendState = "mem";
      };
    */

    power-setup-ac-battery = {
      description = "Setup Energy Profile";
      enable = false;
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${power-script}";
      };
    };
    cpu-boost-control = {
      enable = host != "v7w7r-rc71l";
      description = "Turbo Boost Management";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo ${
          if host == "v7w7r-youyeetoox1" then "0" else "1"
        } > /sys/devices/system/cpu/intel_pstate/no_turbo'";
      };
    };
    limit-cpu-perf = {
      description = "Limit CPU";
      enable = host != "v7w7r-rc71l" && host != "v7w7r-youyeetoox1";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart =
          let
            is-mac = host == "v7w7r-macmini81";
            value = if is-mac then "80" else "70";
          in
          "${pkgs.bash}/bin/bash -c 'echo ${value} > /sys/devices/system/cpu/intel_pstate/max_perf_pct'";
        RemainAfterExit = true;
      };
    };
  };
}

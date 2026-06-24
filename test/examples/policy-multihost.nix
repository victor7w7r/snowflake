{ den, lib, ... }:
{
  x86-workstation =
    { host, ... }:
    lib.optionals (host.system == "x86_64-linux" && (host.name == "superlab" || host.name == "main")) [
      (den.lib.policy.resolve {
        isWorkstation = true;
        supportsGPU = true;
        supportsMultiMonitor = true;
        supportsCUDA = host.name == "superlab";
        maxParallelJobs = 8;
      })
    ];

  mobile-specific =
    { host, ... }:
    lib.optionals (host.system == "aarch64-linux") [
      (den.lib.policy.resolve {
        enablePowerSaving = true;
        disableTurbo = true;
        enableThermalManagement = true;
        limitBackgroundServices = true;
      })
    ];

  den.default.includes = [
    den.policies.x86-workstation
    den.policies.mobile-specific
  ];

  den.aspects.x86-features =
    {
      isX86,
      supportsVT,
      supportsTurbo,
      ...
    }:
    lib.optionalAttrs isX86 {
      nixos =
        { pkgs, ... }:
        {
          virtualisation = lib.optionalAttrs supportsVT {
            libvirtd.enable = true;
            kvm.enable = true;
          };

          boot = lib.optionalAttrs supportsTurbo {
            kernelParams = [ "intel_pstate=passive" ];
          };

          environment.systemPackages = [
            pkgs.pciutils
            pkgs.dmidecode
          ];
        };
    };

  den.aspects.phone-setup =
    {
      isPhone,
      enablePowerSaving,
      limitBackgroundServices,
      ...
    }:
    lib.optionalAttrs isPhone {
      nixos = {
        system.stateVersion = "25.11";
        networking.hostName = "phone";

        powerManagement = lib.optionalAttrs enablePowerSaving {
          enable = true;
          cpuFreqGovernor = "powersave";
          powerButton = "ignore";
        };

        services = lib.optionalAttrs limitBackgroundServices {
          openssh.enable = false; # No SSH en mobile
          fwupd.enable = false; # Firmware updates manuales
          thermald.enable = true;
        };

        boot = {
          kernelParams = [ "slub_debug=0" ]; # Reduce memory
          supportedFilesystems = [ "ext4" ]; # Básico
        };
      };
    };

}

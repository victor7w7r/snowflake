{ generic, ... }:
{
  den = {
    hosts.x86_64-linux.generic = {
      hostName = "v7w7r-generic";
      users.snowflake = { };
    };
    aspects.generic = {
      includes = [
        generic.disks
      ];

      /*
        params = import ./lib/kernel-params.nix;
        boot = import ./lib/boot.nix { };
        btrfs = (import ./lib/btrfs.nix);

        fileSystems = {
          inherit (boot) "/boot" "/boot/emergency";
          "/" = btrfs { };
          "/nix" = btrfs { subvol = "nix"; };
          "/nix/persist" = btrfs {
            subvol = "persist";
            depends = [ "/nix" ];
          };
        };
      */

      nixos =
        { pkgs, modulesPath, ... }:
        {
          imports = [ "${modulesPath}/profiles/qemu-guest.nix" ];
          boot = {
            kernelParams = [
              "intel_pstate=disable"
              "i915.enable_guc=2"
              "i915.enable_psr=0"
            ];
            # ++ params { };
            kernelPackages = pkgs.linuxPackages_6_18;
            initrd = {
              luks.devices.syscrypt = {
                device = "/dev/disk/by-partlabel/disk-main-systempv";
                preLVM = true;
              };
              availableKernelModules = [
                "ahci"
                "xhci_pci"
                "sr_mod"
              ];
            };
          };
        };
    };
  };
}

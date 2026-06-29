{
  den,
  inputs,
  generic,
  kernel,
  ...
}:
{
  #nix build -L ".#nixosConfigurations.generic.config.system.build.toplevel"
  imports = [ (inputs.den.namespace "generic" false) ];

  den = {
    hosts.x86_64-linux.generic.users.snowflake = { };
    aspects.generic = {
      includes = with den.aspects; [
        generic.disks

        base._
        base.tmux._
        base.shell._
        dev._
        initrd._
        networking._
        nix._
        tweaks._
        vim._
        fetch._

        snowflake
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
          networking.hostName = "v7w7r-generic";
          virtualisation.useEFIBoot = true;
          kernelPackages = (kernel.hosts.generic pkgs).generic-kernelPackages;
          imports = [ "${modulesPath}/profiles/qemu-guest.nix" ];
          boot = {
            kernelParams = [
              "intel_pstate=disable"
              "i915.enable_guc=2"
              "i915.enable_psr=0"
            ];
            # ++ params { };
            initrd = {
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

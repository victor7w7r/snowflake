{
  den,
  inputs,
  initrd-services,
  superlab,
  kernel,
  ...
}:
{
  imports = [ (inputs.den.namespace "superlab" false) ];

  den = {
    hosts.aarch64-linux.superlab.users.victor7w7r = { };

    aspects.superlab = {
      includes = with den.aspects; [
        (initrd-services.lib.zram { })
        superlab.disks

        base._
        base.tmux._
        base.shell._
        dev._
        gui._
        initrd._
        networking._
        nix
        plasma._
        sound._
        tweaks._
        vim._
        virtualisation._
        zen._

        android
        bluetooth
        btrfs
        fetch
        forensics
        hardware
        kitty
        persistence
        secrets
        victor7w7r
        zed
      ];

      nixos =
        { pkgs, ... }:
        {
          networking.hostName = "v7w7r-radxarock5b";
          boot = {
            kernelParams = [
              "console=ttyS2,1500000n8"
            ];
            loader = {
              grub.enable = false;
              generic-extlinux-compatible.enable = true;
            };
            kernelPackages = (kernel.hosts.superlab pkgs).superlab-kernelPackages;
            #pkgs.ubootRock5ModelB;
            # kernelPackages = kernel.packages;
          };

          zramSwap = {
            enable = true;
            algorithm = "zstd";
            memoryPercent = 20;
            priority = 100;
          };
        };
    };
  };
}

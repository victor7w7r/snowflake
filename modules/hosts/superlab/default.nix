{ den, inputs, ... }:
{
  imports = [ (inputs.den.namespace "superlab" false) ];

  den = {
    hosts.aarch64-linux.superlab = {
      hostName = "v7w7r-radxarock5b";
      users.victor7w7r = { };
    };

    aspects.superlab = {
      includes = with den.aspects; [
        base._
        base.tmux._
        base.shell._
        dev._
        gui._
        initrd._
        networking._
        nix._
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
        secrets
        victor7w7r
        zed
      ];

      nixos = {
        boot = {
          kernelParams = [
            "console=ttyS2,1500000n8"
          ];
          loader = {
            grub.enable = false;
            generic-extlinux-compatible.enable = true;
          };
          #pkgs.ubootRock5ModelB;
          # kernelPackages = kernel.packages;
        };

        zramSwap = {
          enable = true;
          algorithm = "zstd";
          memoryPercent = 20;
          priority = 100;
        };

        hardware.rockchip.enable = true;
      };
    };
  };
}

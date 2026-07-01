{
  den,
  inputs,
  kernel,
  main,
  ...
}:
{
  imports = [ (inputs.den.namespace "main" false) ];

  den = {
    hosts.x86_64-linux.main.users.victor7w7r = {
      classes = [ "homeManager" ];
    };

    aspects.main = {
      includes = with den.aspects; [
        main.audio
        main.disks
        main.initrd
        main.services

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
        communication
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
          networking.hostName = "v7w7r-macmini81";
          boot = {
            /*
              extraModulePackages = [
              (pkgs.callPackage ./custom/apple-bce.nix { kernel = kernelBuild.kernel; })
              ];
            */
            kernelPackages = (kernel.hosts.main pkgs).main-kernelPackages;
            #audioT2 = (pkgs.callPackage ./custom/t2-pipewire.nix { });
            resumeDevice = "/dev/mapper/swapcrypt";
          };

          swapDevices = [
            {
              device = "/dev/mapper/swapcrypt";
              discardPolicy = "both";
              options = [ "nofail" ];
            }
          ];
          systemd.tmpfiles.rules = [
            "w /sys/block/bcache0/bcache/cache_mode - - - - writethrough"
            "w /sys/block/bcache1/bcache/cache_mode - - - - writethrough"
          ];
        };

      homeManager =
        { config, ... }:
        {
          home.file = {
            "shared".source = config.lib.file.mkOutOfStoreSymlink "/run/media/shared";
            "storage".source = config.lib.file.mkOutOfStoreSymlink "/nix/persist/storage";
          };
        };
    };
  };
}

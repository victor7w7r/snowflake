{
  den,
  inputs,
  server,
  ...
}:
{
  imports = [ (inputs.den.namespace "server" false) ];

  den = {
    hosts.x86_64-linux.server = {
      hostName = "v7w7r-youyeetoox1";
      users.victor7w7r = { };
    };

    aspects.server = {
      includes = with den.aspects; [
        server.disks-logical
        server.disks-physical
        server.initrd
        server.systemd

        base._
        base.tmux._
        base.shell._
        dev._
        initrd._
        networking._
        nix._
        server._
        tweaks._
        virtualisation._
        vim._

        btrfs
        fetch
        forensics
        hardware
        secrets
        xfce
        victor7w7r
        zed
      ];

      nixos =
        { config, pkgs, ... }:
        {

          boot = {
            initrd.services.lvm.enable = true;
            extraModulePackages = [ config.boot.kernelPackages.r8168 ];
            blacklistedKernelModules = [ "r8169" ];
            resumeDevice = "/dev/mapper/swapcrypt";
            kernelParams = [ "pcie_aspm=off" ];
            #kernelPackages = helpers.kernelModuleLLVMOverride (kernelBuild.packages);
            swraid = {
              enable = true;
              mdadmConf = ''
                MAILADDR root
                ARRAY /dev/md/raid0 metadata=1.2 spares=1 UUID=00a19bfc:a0b32154:4ed293e4:28565a8f
              '';
            };
          };

          environment.systemPackages = with pkgs; [
            mdadm
            intel-undervolt
          ];

          zramSwap = {
            enable = true;
            algorithm = "zstd";
            memoryPercent = 100;
            priority = 100;
          };

          services = {
            lvm.boot.thin.enable = true;
            rustdesk.enable = true;
          };

          swapDevices = [
            {
              device = "/dev/mapper/swapcrypt";
              discardPolicy = "both";
              options = [ "nofail" ];
            }
          ];
        };

      homeManager =
        { user, config, ... }:
        {
          home.file = {
            "shared".source = config.lib.file.mkOutOfStoreSymlink "/run/media/shared";
            "cloud".source = config.lib.file.mkOutOfStoreSymlink "/nix/persist/cloud";
            ".xinitrc".text = ''
              export XAUTHORITY=/home/${user}/.Xauthority
              export XDG_SESSION_TYPE=x11
              export DESKTOP_SESSION=xfce
              exec startxfce4
            '';
          };
        };
    };
  };
}

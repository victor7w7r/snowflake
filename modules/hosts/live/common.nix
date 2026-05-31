{ lib, ... }:
{
  /*
    packages = with pkgs; [
    clolcat
    fortune
    ];

    home-manager = {
      backupCommand = "${pkgs.trash-cli}/bin/trash";
      useUserPackages = true;
      useGlobalPkgs = true;
    }

    services.network-manager-applet.enable = true;
  */

  live.common.nixos =
    {
      config,
      modulesPath,
      pkgs,
      ...
    }:
    {
      imports = [
        "${modulesPath}/profiles/base.nix"
        "${modulesPath}/profiles/clone-config.nix"
        "${modulesPath}/profiles/qemu-guest.nix"
        "${modulesPath}/installer/cd-dvd/iso-image.nix"
        "${modulesPath}/installer/cd-dvd/channel.nix"
      ];

      hardware.cpu = {
        amd.updateMicrocode = true;
        intel.updateMicrocode = true;
      };

      image.fileName = "nixstrap-${config.system.nixos.label}.iso";
      swapDevices = lib.mkImageMediaOverride [ ];
      fileSystems = lib.mkImageMediaOverride config.lib.isoFileSystems;

      isoImage = {
        #configurationName = flavor;
        makeEfiBootable = true;
        makeUsbBootable = true;
        squashfsCompression = "xz -Xbcj x86 -Xdict-size 100% -b 512K -limit 75 -percentage";
      };

      networking = with lib; {
        wireless.enable = mkImageMediaOverride true;
      };

      documentation = with lib; {
        man.man-db.enable = mkDefault false;
        enable = mkDefault false;
        doc.enable = mkDefault false;
        info.enable = mkDefault false;
        man.enable = mkDefault false;
        nixos.enable = mkDefault false;
      };

      boot.postBootCommands = ''
        for o in $(</proc/cmdline); do
          case "$o" in
            live.nixos.passwd=*)
              set -- $(IFS==; echo $o)
              echo "nixos:$2" | ${pkgs.shadow}/bin/chpasswd
              ;;
          esac
        done
      '';
    };
}

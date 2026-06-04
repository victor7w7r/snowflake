{ lib, ... }:
{
  den.aspects.virtualisation.libvirt = {
    nixos =
      {
        isIntel,
        isVisual,
        pkgs,
        ...
      }:
      lib.optional isVisual {
        boot.extraModprobeConfig = ''
          options kvm ignore_msrs=1
          ${lib.optionalString isIntel ''
            options kvm-intel nested=1
            options kvm_intel emulate_invalid_guest_state=0
          ''}
        '';

        environment = {
          sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
          persistence."/nix/persist".directories = lib.mkAfter [
            "/var/lib/libvirt"
            "/var/lib/lxc"
            "/var/lib/qemu"
          ];
        };

        environment.systemPackages = with pkgs; [
          bridge-utils
          dialog
          freerdp
          nemu
          netcat-openbsd
          #qemu-user
          #qemu-utils
          usbkvm
          virt-manager
          virt-viewer
          virtio-win
          virtnbdbackup
          win-spice
          yad
          x11_ssh_askpass
          #cockpit-navigator
          #cockpit-storaged
        ];

        programs = {
          mdevctl.enable = true;
          virt-manager.enable = true;
        };

        virtualisation = {
          spiceUSBRedirection.enable = true;
          kvmgt.enable = lib.optionalAttrs isIntel true;
          libvirtd = {
            enable = true;
            qemu = {
              package = pkgs.qemu_kvm;
              runAsRoot = true;
              vhostUserPackages = with pkgs; [ virtiofsd ];
              swtpm.enable = true;
            };
          };
        };
      };

    homeManager =
      { isHandheld, isMain, ... }:
      lib.optional (isHandheld || isMain) {
        programs.looking-glass-client.enable = true;
      };
  };
}

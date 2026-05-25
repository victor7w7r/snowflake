{ lib, hosts-attrs, ... }:
{
  den.aspects.virtualisation.provides =
    lib.genAttrs hosts-attrs.peripheralgui (t: {
      nixos =
        { pkgs, ... }:
        {
          environment.persistence."/nix/persist".directories = lib.mkAfter [
            "/var/lib/libvirt"
            "/var/lib/lxc"
            "/var/lib/qemu"
          ];

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

      homeManager.programs.looking-glass-client.enable = true;
    })
    // lib.genAttrs [ "main" ] (t: {
      virtualisation.kvmgt.enable = true;
    });
}

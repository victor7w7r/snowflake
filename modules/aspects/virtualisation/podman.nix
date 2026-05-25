{ lib, ... }:
{
  den.aspects.virtualisation.provides = lib.genAttrs [ "main" "generic" "superlab" ] (t: {
    nixos =
      { pkgs, ... }:
      {
        #users.extraGroups.podman.members = [ username ];
        environment.systemPackages = with pkgs; [
          arion
          ctop
          distrobox
          distrobox-tui
          dive
          #distrobuilder
          fuse-overlayfs
          oxker
          pods
          podman-tui
        ];

        virtualisation.podman = {
          enable = true;
          autoPrune.enable = true;
          dockerCompat = true;
          dockerSocket.enable = true;
          defaultNetwork.settings.dns_enabled = true;
          extraPackages = with pkgs; [
            conmon
            crun
            iptables
            nftables
            podman-compose
            podman-tui
            slirp4netns
            skopeo
            zfs
          ];
        };
      };
  });

}

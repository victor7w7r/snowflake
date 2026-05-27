{ lib, ... }:
{
  den.aspects.virtualisation.provides = lib.genAttrs [ "main" "generic" "superlab" ] (t: {
    nixos =
      { user, pkgs, ... }:
      {
        #users.extraGroups.podman.members = [ username ];
        environment = {
          systemPackages = with pkgs; [
            arion
            ctop
            devbox
            distrobox
            distrobox-tui
            dive
            #distrobuilder
            fuse-overlayfs
            oxker
            pods
            podman-tui
          ];
          persistence."/nix/persist" = {
            directories = lib.mkAfter [ "/var/lib/waydroid" ];
            users."${user}".directories = lib.mkAfter [ ".local/share/containers" ];
          };
        };
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

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ distroshelf ];
        programs.lazydocker.enable = true;
      };
  });

}

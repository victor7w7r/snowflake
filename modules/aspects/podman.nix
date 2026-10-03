{
  den.aspects.podman =
    { user, ... }:
    {
      nixos =
        { lib, pkgs, ... }:
        {
          environment.persistence."/nix/persist".users."${user.name}".directories = lib.mkAfter [
            ".local/share/containers"
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
            ];
          };
        };

      provides.to-users.homeManager =
        { pkgs, ... }:
        {
          home.packages = with pkgs; [ distroshelf ];
        };
    };
}

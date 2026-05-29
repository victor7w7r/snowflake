{ main, ... }:
{
  den = {
    hosts.x86_64-linux.main.users.victor7w7r = { };

    aspects.main = {
      includes = [
        main.disks
      ];
      #audioT2 = (pkgs.callPackage ./custom/t2-pipewire.nix { });
      nixos = {
      };
    };
  };
}

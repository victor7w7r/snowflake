{ __findFile, ... }:
{
  den = {
    hosts.x86_64-linux.main.users.victor7w7r = { };

    aspects.main = {
      includes = [ ];
      #audioT2 = (pkgs.callPackage ./custom/t2-pipewire.nix { });
      nixos = {
      };
    };
  };
}

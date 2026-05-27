{ den, lib, ... }:
{
  den.aspects.main = {
    includes = [ ];
    #audioT2 = (pkgs.callPackage ./custom/t2-pipewire.nix { });
    nixos = {
    };
  };
}

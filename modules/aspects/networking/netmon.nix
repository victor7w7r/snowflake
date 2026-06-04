{ lib, ... }:
{
  den.aspects.networking.netmon.nixos =
    { isLive, pkgs, ... }:
    lib.optional (!isLive) {
      environment.systemPackages = with pkgs; [
        ariang
        axel
        doggo
        gping
        hblocks
        lazyssh
        netscanner
        openresolv
        #rquickshare
        rustscan
        slirp4netns
        sshs
        speedtest-cli
        #(pkgs.callPackage ./custom/aim.nix { })
        #(pkgs.callPackage ./custom/goto.nix { })
        #https://github.com/akinoiro/ssh-list
      ];
    };
}

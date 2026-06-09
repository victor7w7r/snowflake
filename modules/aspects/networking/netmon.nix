{ lib, ... }:
{
  den.aspects.networking.netmon.nixos =
    { isLive, pkgs, ... }:
    lib.optional (!isLive) {
      environment.systemPackages = with pkgs; [
        aim
        ariang
        axel
        doggo
        gping
        goto
        hblocks
        lazyssh
        netscanner
        openresolv
        rustscan
        slirp4netns
        sshs
        speedtest-cli
        #rquickshare
        #https://github.com/akinoiro/ssh-list
      ];
    };
}

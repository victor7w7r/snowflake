{ lib, ... }:
{
  den.aspects.networking.netmon = {
    os =
      {
        isMainMac,
        isPersistent,
        pkgs,
        ...
      }:
      lib.optionalAttrs (isPersistent || isMainMac) {
        environment.systemPackages = with pkgs; [
          aim
          ariang
          axel
          doggo
          gping
          goto
          lazyssh
          netscanner
          openresolv
          rustscan
          sshs
          speedtest-cli
        ];
      };

    nixos =
      { isPersistent, pkgs, ... }:
      lib.optionalAttrs isPersistent {
        environment.systemPackages = with pkgs; [
          slirp4netns
          #rquickshare
          #https://github.com/akinoiro/ssh-list
        ];
      };
  };
}

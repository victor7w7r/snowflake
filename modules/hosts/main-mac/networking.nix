{ pkgs, ... }:
{
  main-mac.networking.nixos.system = {
    environment.defaultPackages = with pkgs; [
      aria2
      doggo
      gping
      mtr
      rtorrent
      tailscale
      ttyd
      sshs
      speedtest-cli
    ];
  };
}

{
  den.aspects.base.provides.netmon.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ariang
        axel
        doggo
        gping
        hblock
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

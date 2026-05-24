{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
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
      (pkgs.callPackage ./custom/aim.nix { })
      (pkgs.callPackage ./custom/goto.nix { })
      #https://github.com/akinoiro/ssh-list
    ]
    ++ [
      nchat
      reader
      stig
      #(pkgs.callPackage ./custom/carbonyl.nix { })
      (pkgs.callPackage ./custom/discli.nix { })
      (pkgs.callPackage ./custom/termishare.nix { })
      #https://github.com/ayn2op/discordo
      #https://github.com/fetchcord/FetchCord
      #https://github.com/sparklost/endcord
      #https://github.com/smmr-software/mabel
      #uv pip install tewi-transmission
      #pkgtop
    ];
}

{
  den.aspects.base.provides.coreutils = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          atool
          cheat
          brush
          choose
          cmd-wrapped
          cod
          emptty
          file
          fsarchiver
          glow
          gnused
          gnutar
          inotify-tools
          jump
          killall
          lemmeknow
          lsof
          modprobed-db
          p7zip
          progress
          pv
          rsyncy
          #sampler
          seadrive-fuse
          seafile-shared
          sd
          sig
          tmux
          tre-command
          viddy
          vtm
          xz
          wtfutil
          #(pkgs.callPackage ./custom/hf.nix { })
          #(pkgs.callPackage ./custom/loop.nix { })
          #(pkgs.callPackage ./custom/procmux.nix { })
          #(pkgs.callPackage ./custom/progressline.nix { })
          #(pkgs.callPackage ./custom/texoxide.nix { })
        ];

      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          axel
          inxi
          home-manager
        ];
        programs = {
          fd.enable = true;
          ripgrep-all.enable = true;
          rclone.enable = true;
        };
      };
  };
}

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
          exfatprogs
          f2fs-tools
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
          mtools
          ntfs2btrfs
          p7zip
          progress
          pv
          rsyncy
          #sampler
          seadrive-fuse
          seafile-shared
          sshfs
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
          clolcat
          fortune
          mommy
        ];
        programs = {
          fd.enable = true;
          ripgrep-all.enable = true;
          rclone.enable = true;

          bat = {
            enable = true;
            config = {
              pager = "less -FR";
              theme = "Dracula";
            };
          };

          bottom.enable = true;
          btop = {
            enable = true;
            settings = {
              color_theme = "dracula";
              theme_background = false;
              update_ms = 500;
            };
          };
          hwatch.enable = true;

          eza = {
            enable = true;
            enableZshIntegration = true;
            enableBashIntegration = true;
            colors = "always";
            extraOptions = [
              "--group-directories-first"
              "--header"
              "--no-quotes"
            ];
          };

          fzf = {
            enable = true;
            enableZshIntegration = true;
            enableBashIntegration = true;
            defaultOptions = [
              "--height 40%"
              "--reverse"
              "--border"
              "--color=16"
            ];
            defaultCommand = "rg --files --hidden --glob=!.git/";
          };

          zoxide = {
            enable = true;
            enableZshIntegration = true;
            enableBashIntegration = true;
            options = [ "--cmd cd" ];
          };
        };
      };
  };
}

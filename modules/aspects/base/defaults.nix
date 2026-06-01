{ den, lib, ... }:
{
  den.aspects.base = {
    includes = with den.aspects.base._; [
      disk-management
      locale
      nettools
      security
      starship
      den.aspects.shell
      den.aspects.tmux
    ];

    nixos =
      { pkgs, options, ... }:
      {
        environment = {
          enableAllTerminfo = true;
          pathsToLink = [ "/share/applications" ];
          sessionVariables.NIXOS_OZONE_WL = "1";
          systemPackages = with pkgs; [
            atool
            busybox
            brush
            choose
            cod
            exfatprogs
            f2fs-tools
            file
            fsarchiver
            gnused
            gnutar
            killall
            lemmeknow
            lsof
            mtools
            ntfs2btrfs
            p7zip
            progress
            pv
            rsyncy
            sshfs
            sd
            sig
            tmux
            tre-command
            xz
            #(pkgs.callPackage ./custom/hf.nix { })
            #(pkgs.callPackage ./custom/loop.nix { })
            #(pkgs.callPackage ./custom/procmux.nix { })
            #(pkgs.callPackage ./custom/progressline.nix { })
            #(pkgs.callPackage ./custom/texoxide.nix { })
          ];
        };

        console = {
          packages = options.console.packages.default ++ [ pkgs.terminus_font ];
          keyMap = "us-acentos";
        };

        services.speechd.enable = false;

        programs = {
          #bash.blesh.enable = true;
          pay-respects.enable = true;
          zsh.enable = true;
          less.enable = true;
          skim.enable = true;
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
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

          btop = {
            enable = true;
            settings = {
              color_theme = "dracula";
              theme_background = false;
              update_ms = 500;
            };
          };
          nano.enable = false;
          command-not-found.enable = lib.mkDefault false;
          fish.generateCompletions = lib.mkDefault false;

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

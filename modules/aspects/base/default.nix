{ lib, ... }:
{
  den.aspects.base.default = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          atool
          brush
          choose
          cod
          file
          hf
          gnused
          gnutar
          lemmeknow
          #loop
          lsof
          hexyl
          mtools
          p7zip
          phraze
          progress
          pv
          rsyncy
          sshfs
          sd
          sig
          texoxide
          tmux
          tre-command
          udiskie
          xz
        ];

        programs = {
          #bash.blesh.enable = true;
          less.enable = true;
          pay-respects.enable = true;
          skim.enable = true;
          zsh.enable = true;
        };
      };

    nixos =
      {
        hasVisualKeyboard,
        isEfi,
        isGeneric,
        isIntel,
        isMain,
        isServer,
        isPiZero,
        isPersistent,
        isTpm,
        pkgs,
        options,
        ...
      }:
      {
        environment = {
          enableAllTerminfo = true;
          pathsToLink = [ "/share/applications" ];
          sessionVariables.NIXOS_OZONE_WL = "1";
          persistence = lib.optionalAttrs isPersistent {
            "/nix/persist".directories = [
              "/var/lib/containers"
              "/var/lib/nixos-containers"
              (lib.mkIf isTpm "/var/lib/sbctl")
            ];
          };
          systemPackages =
            with pkgs;
            [
              busybox
              btrfs-progs
              btdu
              exfatprogs
              f2fs-tools
              fsarchiver
              killall
              ntfs2btrfs
              #procmux
              progressline
            ]
            ++ lib.optionals isEfi [
              efibooteditor
              efibootmgr
            ]
            ++ lib.optionals isTpm [
              mokutil
              tpm2-tools
              sbctl
            ];
        };

        console = {
          packages = options.console.packages.default ++ [ pkgs.terminus_font ];
          keyMap = "us-acentos";
        };

        services = {
          envfs.enable = true;
          fstrim.enable = true;
          fwupd.enable = hasVisualKeyboard;
          logrotate.enable = isPersistent;
          orca.enable = lib.mkForce false;
          speechd.enable = false;
          thermald.enable = isIntel;
          upower.enable = (!isMain && !isServer && !isGeneric && !isPiZero);
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
              "italic-text" = "always";
              style = "numbers";
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

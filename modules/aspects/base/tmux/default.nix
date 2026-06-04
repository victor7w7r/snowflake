{ lib, ... }:
{
  den.aspects.base.tmux.default = {
    nixos =
      { isPersistent, user, ... }:
      lib.optional isPersistent {
        environment.persistence."/nix/persist".users."${user}".directories = lib.mkAfter [ ".tmux" ];
      };

    homeManager =
      { pkgs, ... }:
      {
        programs.tmux = {
          enable = true;
          baseIndex = 1;
          aggressiveResize = true;
          disableConfirmationPrompt = true;
          clock24 = false;
          escapeTime = 0;
          historyLimit = 100000;
          keyMode = "vi";
          mouse = true;
          prefix = "C-a";
          sensibleOnTop = false;
          shell = "${pkgs.zsh}/bin/zsh";
          extraConfig =
            let
              status = pkgs.callPackage ./shell/status.nix { };
              foreground = pkgs.callPackage ./shell/foreground.nix { };
              colors = pkgs.callPackage ./shell/colors.nix { };
            in
            ''
              run ${status}
              run -b ${foreground}
              run -b ${colors}
            '';
        };
      };
  };
}

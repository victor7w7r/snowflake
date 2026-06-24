{
  inputs,
  lib,
  tmux,
  ...
}:
{
  imports = [ (inputs.den.namespace "tmux" false) ];

  den.aspects.base.tmux.default = {
    nixos =
      { isPersistent, user, ... }:
      lib.optional isPersistent {
        environment.persistence."/nix/persist".users."${user.name}".directories = lib.mkAfter [ ".tmux" ];
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
          extraConfig = ''
            run ${
              pkgs.writeShellScript "status" tmux.shell.status {
                git = pkgs.writeShellScript "git-ext" tmux.ext.git;
                ssh = pkgs.writeShellScript "ssh-ext" tmux.ext.ssh;
                colors = pkgs.writeShellScript "colors-ext" tmux.ext.colors;
                network = pkgs.writeShellScript "network-ping" tmux.ext.network-ping;
                ram = pkgs.writeShellScript "ram-ext" tmux.ext.ram-info;
                cpu = pkgs.writeShellScript "cpu-ext" tmux.ext.cpu-info;
                battery = pkgs.writeShellScript "battery-ext" tmux.ext.battery;
              }
            }
            run -b ${pkgs.writeShellScript "foreground" tmux.shell.foreground}
            run -b ${pkgs.writeShellScript "colors" tmux.shell.colors}
          '';
        };
      };
  };
}

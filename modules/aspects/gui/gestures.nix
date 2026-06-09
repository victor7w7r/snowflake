{ lib, ... }:
{
  flake-file.inputs.gestures.url = "github:ferstar/gestures";

  den.aspects.gui.gestures = {
    nixos =
      {
        isMain,
        isSuperlab,
        pkgs,
        ...
      }:
      lib.optional (isMain || isSuperlab) {
        environment.systemPackages = with pkgs; [ ydotool ];
        programs.ydotool.enable = true;
        services.udev.extraRules = ''KERNEL=="uinput", MODE="0660", GROUP="input"'';
      };

    homeManager =
      {
        inputs',
        isMain,
        isSuperlab,
        pkgs,
        ...
      }:
      lib.optional (isMain || isSuperlab) {
        home.packages = [
          inputs'.gestures.packages."x86_64-linux".gestures
          pkgs.tablet-map
        ];

        xdg.configFile."gestures.kdl".text =
          ''swipe direction="any" fingers=3 mouse-up-delay=500 acceleration=10'';

        systemd.user.services = {
          gestures = {
            Service = {
              ExecStart = "${inputs'.gestures.packages."x86_64-linux".gestures}/bin/gestures start";
              ExecReload = "${inputs'.gestures.packages."x86_64-linux".gestures}/bin/gestures reload";
              Restart = "no";
              StandardOutput = "journal";
              StandardError = "journal";
            };
            Install.WantedBy = [ "default.target" ];
          };
          tablet-map = {
            Service = {
              ExecStart = "${pkgs.tablet-map}/bin/tablet_map";
              Restart = "no";
              StandardOutput = "journal";
              StandardError = "journal";
            };
            Install.WantedBy = [ "default.target" ];
          };
        };
      };
  };
}

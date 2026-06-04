{ lib, ... }:
{
  den.aspects.bluetooth.nixos =
    { isPersistent, pkgs, ... }:
    {
      environment = lib.mkMerge [
        {
          systemPackages = with pkgs; [
            bluetui
            bluetuith
          ];
        }
        (lib.mkIf isPersistent {
          persistence."/nix/persist".directories = [
            "/var/lib/bluetooth"
          ];
        })
      ];

      services.blueman.enable = true;
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
            FastConnectable = "true";
            JustWorksRepairing = "always";
            MultiProfile = "multiple";
            Experimental = true;
          };
        };
      };
    };
}

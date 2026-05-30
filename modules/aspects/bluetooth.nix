{ ... }:
{
  den.aspects.bluetooth.nixos =
    { pkgs, ... }:
    {
      environment = {
        persistence."/nix/persist".directories = [ "/var/lib/bluetooth" ];
        systemPackages = with pkgs; [
          bluetui
          bluetuith
        ];
      };

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

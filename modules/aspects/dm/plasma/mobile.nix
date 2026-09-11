{
  den.aspects.plasma.mobile = { user, ... }: {
    nixos =
      {
        lib,
        isPhone,
        pkgs,
        self',
        ...
      }:
      lib.optionalAttrs isPhone {
        services.xserver.enable = true;
        environment = {
          persistence."/nix/persist".users."${user.name}" = {
            directories = [ ".config/plasma-mobile" ];
            #files = [ ".config/plasmamobilerc" ];
          };
          plasma6.excludePackages = with pkgs.kdePackages; [
          	kcalc
           	systemsettings
          ];
          systemPackages =
            with pkgs.kdePackages;
            with self'.packages;
            [
              angelfish
              audiotube
              calindori
              elisa
              #index-fm
              kalk
              kclock
              koko
              krecorder
              plasma-camera
              plasma-dialer
              plasma-mobile
              plasma-phonebook
              plasma-settings
              plasmatube
              qmlkonsole
              spacebar
            ];
        };
      };
  };
}

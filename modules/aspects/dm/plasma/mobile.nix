{
  den.aspects.plasma.mobile = { user, ... }: {
    nixos =
      {
        lib,
        isPhone,
        pkgs,
        ...
      }:
      lib.optionalAttrs isPhone {
        services.xserver.enable = true;
        environment = {
          persistence."/nix/persist".users."${user.name}" = {
            directories = [ ".config/plasma-mobile" ];
            files = [ ".config/plasmamobilerc" ];
          };
          systemPackages = with pkgs.kdePackages; [
          	kalk
            plasma-dialer
            plasma-mobile
            plasma-nano
            spacebar
          ];
        };
      };
  };
}

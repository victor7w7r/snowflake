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
        persistence."/nix/persist".users."${user.name}".files = [ ".config/plasmamobilerc" ];
        environment.systemPackages = with pkgs.kdePackages; [
          plasma-mobile
          plasma-nano
          plasma-dialer
          spacebar
        ];
      };
  };
}

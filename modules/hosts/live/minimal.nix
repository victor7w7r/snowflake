{
  lib,
  live,
  __findFile,
  ...
}:
{
  den = {
    hosts.x86_64-linux.minimal-live.users.snowflake = { };
    aspects.minimal-live = {
      includes = [
        live.common
        <base>
        <fetch>
        <initrd>
      ];
      nixos = {
        isoImage.edition = lib.mkOverride 500 "minimal";
        fonts.fontconfig.enable = lib.mkOverride 500 false;
        system.nixos.variant_id = lib.mkDefault "minimal";

        xdg = with lib; {
          autostart.enable = mkDefault false;
          icons.enable = mkDefault false;
          mime.enable = mkDefault false;
          sounds.enable = mkDefault false;
        };
      };
    };
  };
}

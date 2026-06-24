{
  den,
  lib,
  live,
  ...
}:
{
  den = {
    hosts.x86_64-linux.minimal-live = {
      hostName = "v7w7r-live";
      users.snowflake = { };
    };
    aspects.minimal-live = {
      includes = with den.aspects; [
        live.common
        (den.batteries.tty-autologin "snowflake")

        base._
        base.tmux._
        base.shell._
        dev._
        initrd._
        networking._
        nix._
        tweaks._
        vim._

        btrfs
        hardware
        secrets
        snowflake
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

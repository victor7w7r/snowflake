{ lib, hosts-attrs, ... }:
let
  tpm-configs = lib.genAttrs hosts-attrs.tpm (_: {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          mokutil
          tpm2-tools
          sbctl
        ];
      };
  });
  efi-configs = lib.genAttrs hosts-attrs.efi (_: {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          efibooteditor
          efibootmgr
        ];
      };
  });
in
{
  den.aspects.base.provides.coreutils = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          choose
          curlFull
          cod
          cyme
          dos2unix
          emptty
          ethtool
          file
          glow
          gnused
          gnutar
          i2c-tools
          iio-sensor-proxy
          inetutils
          iptables
          jless
          jump
          killall
          lemmeknow
          lm_sensors
          lshw
          lsof
          mtools
          net-tools
          p7zip
          rsyncy
          tmux
          usbutils
          viddy
          vtm
          wget
          wget2
          xz
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          axel
          inxi
          home-manager
        ];
        programs = {
          fd.enable = true;
          ripgrep-all.enable = true;
          rclone.enable = true;
        };
      };

    provides = tpm-configs // efi-configs;
  };
}

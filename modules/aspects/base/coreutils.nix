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
          curlFull
          cyme
          ethtool
          file
          gnused
          gnutar
          i2c-tools
          inetutils
          iptables
          killall
          lm_sensors
          lshw
          lsof
          mtools
          net-tools
          p7zip
          usbutils
          viddy
          wget
          wget2
          xz
        ];
      };

    provides = tpm-configs // efi-configs;
  };
}

{
  inputs,
  lib,
  hosts-attrs,
  ...
}:
{

  flake-file.inputs.catppuccin-refind = {
    url = "github:catppuccin/refind";
    flake = false;
  };

  den.aspects.boot.provides.refind.provides = lib.genAttrs hosts-attrs.x86 (t: {
    nixos =
      { pkgs, ... }:
      {
        system.boot.loader.id = "refind";
        system.build.installBootLoader = pkgs.stdenvNoCC.mkDerivation {
          pname = "boot-loader";
          version = "1.0";

          /*
            inherit
            refind
            edk2-uefi-shell
            memtest86-efi
            fwupd-efi
            catppuccin-refind
            ;
          */
        };
      };
  });
}

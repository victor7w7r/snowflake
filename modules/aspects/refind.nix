{
  flake-file.inputs.catppuccin-refind = {
    url = "github:catppuccin/refind";
    flake = false;
  };

  den.aspects.refind = {
    nixos =
      { pkgs, ... }:
      {
        boot.loader = {
          grub.enable = false;
          systemd-boot.enable = false;
          efi = {
            efiSysMountPoint = "/boot/EFI";
            canTouchEfiVariables = true;
          };
        };

        system = {
          boot.loader.id = "refind";
          build.installBootLoader = pkgs.stdenvNoCC.mkDerivation {
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
      };
  };
}

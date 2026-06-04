{ lib, ... }:
{
  den.aspects.tweaks.firmware = {
    nixos =
      { isX86, pkgs, ... }:
      {
        nixpkgs.overlays = lib.mkIf isX86 [
          (pkgs: prev: {
            linux-firmware = prev.linux-firmware.overrideAttrs (o: {
              postInstall = ''
                rm -rf "$out"/lib/firmware/{netronome,qcom,mellanox,mrvl,ath11k,ath10k,libertas,nvidia,liquidio,cxgb4,ti-connectivity,qed}
                find -L "$out" -type l -delete
              '';
            });
          })
        ];

        hardware = lib.optionalAttrs isX86 {
          enableAllFirmware = lib.mkForce false;
          enableRedistributableFirmware = lib.mkForce false;

          firmware = with pkgs; [
            linux-firmware
            /*
              rtl8192su-firmware
              rtl8761b-firmware
            */
          ];
        };
      };
  };
}

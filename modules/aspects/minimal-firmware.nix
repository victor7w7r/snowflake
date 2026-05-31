{ lib, ... }:
{
  den.aspects.minimal-firmware.nixos =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (pkgs: prev: {
          linux-firmware = prev.linux-firmware.overrideAttrs (o: {
            postInstall = ''
              rm -rf "$out"/lib/firmware/{netronome,qcom,mellanox,mrvl,ath11k,ath10k,libertas,nvidia,liquidio,cxgb4,ti-connectivity,qed}
              find -L "$out" -type l -delete
            '';
          });
        })
      ];

      hardware = {
        enableAllFirmware = lib.mkForce false;
        enableRedistributableFirmware = lib.mkForce false;
        firmware = with pkgs; [ linux-firmware ];
      };
    };
}

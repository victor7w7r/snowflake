{ inputs, ... }: {
  den.aspects.phone.services.adbd.nixos = { pkgs, ... }: {
    systemd.services.adbd = {
      description = "adb daemon";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Restart = "always";
        ExecStart =
          "${inputs.mobile-nixos}/overlay"
          |> (
            route:
            pkgs.callPackage "${route}/adbd" {
              libhybris = pkgs.callPackage "${route}/libhybris" {
                android-headers = pkgs.callPackage "${route}/android-headers" { };
              };
            }
          )
          |> (adbd: "${adbd}/bin/adbd");
      };
    };
  };
}

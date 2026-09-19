{
  den.aspects.phone.services.qrtr.nixos =
    { pkgs, self', ... }:
    {
      systemd.services = {
        qrtr-ns = {
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            ExecStart = "${pkgs.qrtr}/bin/qrtr-ns -f 1";
            Restart = "always";
          };
        };

        pd-mapper = {
          description = "Qualcomm Protection Domain Mapper";
          wantedBy = [ "multi-user.target" ];
          requires = [ "qrtr-ns.service" ];
          after = [ "qrtr-ns.service" ];
          serviceConfig = {
            ExecStart = "${self'.packages.pd-mapper}/bin/pd-mapper";
            Restart = "always";
          };
        };
      };
    };
}

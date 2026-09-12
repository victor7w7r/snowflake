{
  den.aspects.phone.services.q6voiced.nixos = { self', ... }: {
    systemd.services.q6voiced = {
      description = "Enable q6voice audio when call is performed with ModemManager";
      wantedBy = [ "multi-user.target" ];
      after = [
        "ModemManager.service"
        "dbus.service"
      ];
      requires = [ "dbus.service" ];
      serviceConfig = {
        ExecStart = "${self'.packages.q6voiced}/bin/q6voiced hw:0,6";
        Restart = "always";
      };
    };
  };
}

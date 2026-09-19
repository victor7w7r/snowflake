{
  den.aspects.phone.services.q6voiced.nixos = { self', ... }: {
    systemd.services.q6voiced = {
      description = "QDSP6 voice call audio bridge";
      wantedBy = [ "multi-user.target" ];
      after = [ "dbus.service" ];
      requires = [ "dbus.service" ];
      serviceConfig = {
        ExecStart = "${self'.packages.q6voiced}/bin/q6voiced hw:0,6";
        Restart = "always";
        RestartSec = "2";
      };
    };
  };
}

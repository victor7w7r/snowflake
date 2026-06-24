{ den, lib, ... }:
{
  den.policies.exclude-pizero =
    { host, ... }:
    lib.optionals (host.name != "pizero") [
      (den.lib.policy.resolve {
        # Enriquece contexto para indicar que NO es pizero
        isNotPizero = true;
      })
    ];

  den.aspects.igloo =
    { isNotPizero, ... }:
    {
      nixos = lib.optionalAttrs isNotPizero {
        services.fwupd.enable = true;
        boot.kernelParams = [ "some_param" ];
      };
    };

  den.default.includes = [
    den.policies.exclude-pizero
    den.aspects.igloo
  ];

}

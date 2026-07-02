{ den, ... }:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };

  den.policies.host-guards =
    { host, ... }:
    [
      (den.lib.policy.resolve {
        isNixos = host.class == "nixos";
      })
    ];

  den.policies.platform-info =
    { isNixos, ... }:
    [
      (den.lib.policy.resolve {
        platform = if isNixos then "linux" else "other";
      })
    ];

  den.default.includes = [
    den.policies.host-guards
    den.policies.platform-info
  ];

  den.aspects.platform-test =
    { platform }:
    {
      nixos.environment.variables.PLATFORM = platform;
    };

  den.aspects.igloo.includes = [ den.aspects.platform-test ];
}

{ den, ... }:
{
  den.policies.sysctl-to-boot =
    { host, ... }:
    [
      (den.lib.policy.route {
        fromClass = "sysctl";
        intoClass = host.class;
        path = [
          "boot"
          "kernel"
        ];
      })
    ];

  den.default.includes = [ den.policies.sysctl-to-boot ];
}

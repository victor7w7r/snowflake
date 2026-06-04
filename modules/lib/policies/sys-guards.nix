{ den, __findFile, ... }:
{
  den.policies.sys-guards =
    { host, ... }:
    [
      (den.lib.policy.resolve {
        isX86 = host.system == "x86_64-linux";
        isArm = host.system == "aarch64-linux";
        isNixos = host.class == "nixos";
        isDarwin = host.class == "darwin";
      })
    ];

  den.default.includes = [ <den.policies.sys-guards> ];
}

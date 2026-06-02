{ den, ... }:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };

  den.policies.host-guards =
    { host, ... }:
    [
      (den.lib.policy.resolve {
        isNixos = host.class == "nixos";
        isDarwin = host.class == "darwin";
      })
    ];

  den.default.includes = [ den.policies.host-guards ];

  den.aspects.gpg-agent =
    { isNixos }:
    {
      nixos = { lib, ... }: lib.optionalAttrs isNixos { services.openssh.enable = true; };
    };

  den.aspects.igloo.includes = [ den.aspects.gpg-agent ];

  #den.schema.host.includes = [  den.policies.enrichment ]; #TODOS
  #den.aspects.igloo.includes = [  den.policies.enrichment ]; #UN HOST

  den.hosts.aarch64-darwin.apple = { };

  den.aspects.apple = {
    darwin =
      { isDarwin, lib, ... }:
      lib.optionalAttrs isDarwin {
        system.defaults.dock.autohide = true;
      };
  };

}

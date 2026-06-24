{ den, lib, ... }:
{
  den.aspects.igloo = {
    policies.to-alice =
      { user, ... }:
      lib.optional (user.name == "alice") (
        den.lib.policy.include {
          homeManager.programs.tmux.enable = user.name == "alice";
        }
      );

    includes = [ den.aspects.igloo.policies.to-alice ];
  };

  den.aspects.alice = {
    policies.to-igloo =
      { host, ... }:
      lib.optional (host.name == "igloo") (
        den.lib.policy.provide {
          class = "nixos";
          module.programs.nh.enable = true;
        }
      );
  };

}

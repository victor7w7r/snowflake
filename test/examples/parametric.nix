{
  test-wsl-from-parametric-include =
    {
      den,
      igloo,
      lib,
      ...
    }:
    {
      den.hosts.x86_64-linux.igloo = {
        wsl.enable = true;
        wsl.module = { };
        users.tux = { };
      };

      den.aspects.igloo = {
        includes = [
          (
            { host, ... }:
            lib.optionalAttrs (host.class == "nixos") {
              wsl.defaultUser = "tux";
            }
          )
        ];
      };

      expr = igloo.wsl.defaultUser;
      expected = "tux";
    };
}

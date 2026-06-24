{
  den,
  inputs,
  reuse,
  ...
}:
{
  imports = [ (inputs.den.namespace "reuse" false) ];

  reuse.lib = {
    functor =
      { pkgs }:
      {
        testeable = with pkgs; [
          exfatprogs
          sshfs
        ];
      };
  };

  den.aspects.inject =
    {
      test ? "test",
    }:
    {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages =
            with pkgs;
            [ go-audit ] ++ (reuse.lib.functor { inherit pkgs; }).testeable;
        };
    };

  den.default.includes = [ (den.aspects.inject { }) ];
}

{ den, inputs, ... }:
{
  den.aspects.snowflake = {
    includes = [ den.batteries.primary-user ];

    user =
      { pkgs, ... }:
      {
        description = "snowflake";
        shell = pkgs.zsh;
        linger = true;
      };

    nixos = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
  };
}

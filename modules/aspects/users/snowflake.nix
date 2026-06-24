{ den, inputs, ... }:
{
  den.aspects.snowflake = {
    includes = [
      den.batteries.primary-user
      den.batteries.inputs'
      (den.batteries.user-shell "zsh")
    ];

    provides.to-hosts.nixos = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
  };
}

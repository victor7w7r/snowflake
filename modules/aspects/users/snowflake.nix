{ den, inputs, ... }:
{
  den.aspects.snowflake = {
    includes = [ den.batteries.primary-user ];

    user =
      { pkgs, ... }:
      {
        description = "snowflake";
        shell = pkgs.zsh;
        hashedPassword = "$y$j9T$ieUYJ2thSsvR1M37kWe651$yt0z7Ga3..johS8fyA1Y9GaoddW.jfE838xXiFhcus1";
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

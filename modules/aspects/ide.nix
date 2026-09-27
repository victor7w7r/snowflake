{
  den.aspects.ide =
    { lib, user, ... }:
    {
      nixos.environment.persistence."/nix/persist".users."${user.name}".directories = lib.mkAfter [
        ".config/bruno"
        ".config/JetBrains"
        ".local/share/JetBrains"
      ];

      provides.to-users.homeManager =
        { pkgs, ... }:
        {
          home.packages = with pkgs; [
            bruno
            jetbrains.datagrip
            windterm
          ];
        };
    };
}

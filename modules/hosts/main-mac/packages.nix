{
  main-mac.homeManager.packages.nixos =
    { pkgs, ... }:
    {
      home.packages = (
        with pkgs;
        [
          lazygit
        ]
      );
    };
}

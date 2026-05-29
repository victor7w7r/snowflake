{ __findFile, ... }:
{
  flake-file.inputs = {
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    flakehub.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  /*
    home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;

    users.victor7w7r = {
      programs.home-manager.enable = true;
      home.stateVersion = "24.05";
    };
    };
  */

  den = {
    hosts.x86_64-darwin.main-mac.users.victor7w7r = { };
    # sudo -H nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch --flake .#macmini
    aspects.main-mac = {
      includes = [ ];

      nixos =
        { inputs, ... }:
        {
          imports = [
            inputs.nix-homebrew.darwinModules.nix-homebrew
            inputs.determinate.darwinModules.default
          ];
          #determinateNix = determinate.inputs.nix.packages."x86_64-darwin".default;
        };
    };
  };
}

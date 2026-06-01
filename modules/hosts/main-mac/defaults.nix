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
    hosts.x86_64-darwin.main-mac = {
      hostName = "v7w7r-macmini81";
      users.victor7w7r = { };
    };
    # sudo -H nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch --flake .#macmini
    aspects.main-mac = {
      includes = [
        <kitty>
        <starship>
      ];

      nixos =
        {
          inputs,
          pkgs,
          user,
          ...
        }:
        {
          imports = [
            inputs.nix-homebrew.darwinModules.nix-homebrew
            inputs.determinate.darwinModules.default
          ];
          #determinateNix = determinate.inputs.nix.packages."x86_64-darwin".default;

          /*
            users.users.${user} = {
              name = "${user}";
              home = "/Users/${user}";
              shell = pkgs.zsh;
              };
          */

          system.primaryUser = user;
          time.timeZone = "America/Guayaquil";

          environment = {
            variables.RLIMIT_NOFILE = "65536";
            pathsToLink = [ "/Applications" ];
            systemPath = [ "/usr/local/bin" ];
            etc = {
              home-manager.source = "${inputs.home-manager}";
              nixpkgs.source = "${pkgs.path}";
              stable.source = "${inputs.stable}";
              "sudoers.d/timeout".text = ''
                Defaults timestamp_timeout=30
              '';
              "gitconfig".text = ''
                [filter "lfs"]
                  clean = git-lfs clean -- %f
                  smudge = git-lfs smudge -- %f
                  process = git-lfs filter-process
                  required = true
              '';

            };
          };
        };

      homeManager.packages.nixos =
        { pkgs, ... }:
        {
          home.packages = (
            with pkgs;
            [
              lazygit
            ]
          );
        };
    };
  };
}

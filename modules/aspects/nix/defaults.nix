{ den, ... }:
{
  flake-file.inputs = {
    nix-alien.url = "https://flakehub.com/f/thiagokokada/nix-alien/0.1";
    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
  };

  den.aspects.nix = {
    includes = with den.aspects.nix._; [ settings ];

    nixos =
      { inputs, pkgs, ... }:
      {
        imports = [ inputs.nix-search-tv.packages.x86_64-linux.default ];

        environment.systemPackages = with pkgs; [
          alejandra
          cached-nix-shell
          comma
          deadnix
          lorri
          fh
          manix
          namaka
          niv
          #inputs.nix-alien.packages.${system}.nix-alien
          nix-diff
          nix-du
          nix-health
          nix-init # !!!!!
          nix-melt
          nix-output-monitor
          nixpkgs-review
          nix-search-cli
          nix-tree
          nix-update
          nixfmt
          nvd
          optnix
          statix
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        programs.nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep 10 --keep-since 5d";
        };

        home.packages = with pkgs; [ cachix ];
      };
  };
}

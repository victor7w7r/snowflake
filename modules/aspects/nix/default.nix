{ inputs, ... }:
{
  flake-file.inputs = {
    nix-alien.url = "https://flakehub.com/f/thiagokokada/nix-alien/0.1";
    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
  };

  den.aspects.nix.default = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          alejandra
          cached-nix-shell
          comma
          cachix
          deadnix
          lorri
          manix
          namaka
          niv
          nix-diff
          nix-du
          nix-health
          nix-init
          nix-melt
          nix-output-monitor
          nix-search-cli
          nix-tree
          nix-update
          nixfmt
          nvd
          optnix
          statix
        ];
      };

    nixos =
      { pkgs, ... }:
      {
        #imports = [ inputs.nix-search-tv.packages.x86_64-linux.default ];
        environment.systemPackages = [
          #inputs.nix-alien.packages.${system}.nix-alien
        ];
      };
  };
}

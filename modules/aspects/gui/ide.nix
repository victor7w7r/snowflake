{ inputs, ... }:
{
  flake-file.inputs.claude-desktop = {
    url = "github:k3d3/claude-desktop-linux-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.gui.provides.main.homeManager =
    { pkgs, ... }:
    {
      home.packages = (
        with pkgs;
        [
          bruno
          jetbrains.datagrip
          windterm
          (inputs.claude-desktop.packages.${system}.claude-desktop.override {
            nodePackages = { inherit (pkgs) asar; };
          })
        ]
      );
    };
}

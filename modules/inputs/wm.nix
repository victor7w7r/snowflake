{
  flake-file.inputs = {
    hyprland.url = "https://flakehub.com/f/hyprwm/Hyprland/0.53";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprpicker.url = "github:hyprwm/hyprpicker";

    kwin-effects-better-blur-dx = {
      url = "github:xarblu/kwin-effects-better-blur-dx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    pyprland.url = "github:hyprland-community/pyprland";
  };
}

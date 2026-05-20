{
  flake-file.inputs = {
    catppuccin-refind = {
      url = "github:catppuccin/refind";
      flake = false;
    };

    nix-alien.url = "https://flakehub.com/f/thiagokokada/nix-alien/0.1";

    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.7.0";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
  };
}

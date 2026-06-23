{
  flake-file.inputs = {
    batfetch = {
      url = "github:ashish-kus/batfetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swiftfetch = {
      url = "github:ly-sec/swiftfetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.fetch = {
    os =
      { pkgs, self', ... }:
      {
        environment.systemPackages = with pkgs; [
          self'.packages.aerofetch
          self'.packages.cargofetch
          countryfetch
          self'.packages.customfetch
          self'.packages.envfetch
          freshfetch
          macchina
          nerdfetch
          octofetch
          onefetch
          pfetch-rs
          uwufetch
          self'.packages.treefetch
        ];
      };

    nixos =
      {
        #inputs',
        pkgs,
        #host,
        self',
        ...
      }:
      {
        environment.systemPackages = with pkgs; [
          cpufetch
          microfetch
          ramfetch
          self'.packages.mfetch
          self'.packages.bestfetch
          self'.packages.hwfetch
          self'.packages.zeitfetch
          self'.packages.osu-cli
          self'.packages.songfetch
          self'.packages.kat-oh
          #inputs'.batfetch.packages.${host.system}.default
          #inputs.swiftfetch.packages.${pkgs.system}.swiftfetch
        ];
      };

    homeManager.programs.fastfetch = {
      enable = true;
    };
  };
}

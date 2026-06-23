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
          self'.packages.bestfetchrtfg
          self'.packages.hwfetch
          self'.packages.zeitfetch
          #https://github.com/kartavkun/osu-cli
          #https://github.com/ekrlstd/songfetch
          #https://github.com/mustard-parfait/Kat-OH
          #https://github.com/FrenzyExists/frenzch.sh
          #https://github.com/mehedirm6244/sysfex
          #https://github.com/Dr-Noob/gpufetch
          #https://github.com/hexisXz/hexfetch
          #inputs'.batfetch.packages.${host.system}.default
          #inputs.swiftfetch.packages.${pkgs.system}.swiftfetch
        ];
      };

    homeManager.programs.fastfetch = {
      enable = true;
    };
  };
}

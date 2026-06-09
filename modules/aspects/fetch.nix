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
    nixos =
      { inputs', pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          aerofetch
          cargofetch
          countryfetch
          customfetch
          cpufetch
          envfetch
          freshfetch
          macchina
          microfetch
          nerdfetch
          octofetch
          onefetch
          pfetch-rs
          ramfetch
          uwufetch
          treefetch
          inputs'.batfetch.packages.${pkgs.system}.default
          #inputs.swiftfetch.packages.${pkgs.system}.swiftfetch

          #https://github.com/xdearboy/mfetch
          #https://gitlab.com/Maxb0tbeep/bestfetch
          #https://github.com/morr0ne/hwfetch
          #https://github.com/nidnogg/zeitfetch
          #https://github.com/kartavkun/osu-cli
          #https://github.com/ekrlstd/songfetch
          #https://github.com/mustard-parfait/Kat-OH
          #https://github.com/FrenzyExists/frenzch.sh
          #https://github.com/mehedirm6244/sysfex
          #https://github.com/Dr-Noob/gpufetch
          #https://github.com/hexisXz/hexfetch
        ];
      };

    homeManager.programs.fastfetch = {
      enable = true;
    };
  };
}

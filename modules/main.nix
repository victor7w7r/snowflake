{ den, settings, ... }:
{
  _module.args.__findFile = den.lib.__findFile;

  flake-file.nixConfig = settings.lib.settings // {
    lazy-trees = true;
    submodules = true;
  };

  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.inputs'
      den.batteries.self'
    ];
    nixos = {
      system.stateVersion = "26.05";
      documentation = {
        enable = false;
        doc.enable = false;
        info.enable = false;
        man.enable = false;
      };
      nix.settings = settings.lib.flake-config // settings.lib.nix-config;
      nixpkgs.config.allowUnfree = true;
      programs.nix-ld.enable = true;
      #package = lib.mkDefault (pkgs.lix);
    };
  };
}

{
  den,
  lib,
  settings,
  ...
}:
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
      documentation.enable = lib.mkDefault false;
      nixpkgs.config.allowUnfree = true;
      programs.nix-ld.enable = true;
      #package = lib.mkDefault (pkgs.lix);

      nix.settings = {
        narinfo-cache-negative-ttl = 0;
        max-substitution-jobs = 128;
        keep-build-log = lib.mkDefault false;
        http-connections = 128;
        keep-derivations = lib.mkDefault false;
        max-jobs = "auto";
        cores = 0;

        trusted-users = [
          "root"
          "@wheel"
        ];
      }
      // settings.lib.settings;
    };
  };
}

{
  conf,
  inputs,
  lib,
  ...
}:
{

  den.default = {
    os = {
      #imports = [ inputs.home-manager.nixosModules.home-manager ];

      nixpkgs.config.allowUnfree = true;
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "hm-backup";
        sharedModules = [
          (
            { lib, ... }:
            {
              programs.home-manager.enable = true;
              home = {
                enableNixpkgsReleaseCheck = false;
                language.base = "es_ES.UTF-8";
              };
              manual = {
                html.enable = lib.mkDefault false;
                json.enable = lib.mkDefault false;
                manpages.enable = lib.mkDefault false;
              };
            }
          )
        ];
      };
    };

    homeManager =
      { config, ... }:
      {
        home.file."repositories/snowflake".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
      };

    nixos =
      { pkgs, ... }:
      let

      in
      {
        system.stateVersion = conf.lib.config.stateVersion;
        nix.settings =
          (removeAttrs conf.lib.config.flake-config [ "__provider" ])
          // (removeAttrs conf.lib.config.nix-config [ "__provider" ]);
        nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
        programs.nix-ld.enable = true;
        documentation = {
          enable = false;
          doc.enable = false;
          info.enable = false;
          man.enable = false;
        };
        #package = lib.mkDefault (pkgs.lix);
        home-manager = {
          backupCommand = "${pkgs.trash-cli}/bin/trash";
          sharedModules = [
            (
              { ... }:
              {
                systemd.user.startServices = "sd-switch";
                home.stateVersion = conf.lib.config.stateVersion;
              }
            )
          ];
        };
      };

    darwin = {
      imports = [ inputs.determinate.darwinModules.default ];
      system = {
        checks.verifyBuildUsers = false;
        stateVersion = 6;
      };
      nix = {
        enable = lib.mkForce false;
        nixPath = lib.mkDefault [ ];
        optimise.automatic = lib.mkDefault false;
      };
      determinateNix.customSettings = {
        flake-registry = "/etc/nix/flake-registry.json";
        sandbox = "relaxed";
      }
      // conf.lib.config.flake-config
      // conf.lib.config.nix-config;
    };
  };
}

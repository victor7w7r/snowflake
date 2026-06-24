{ den, lib, ... }:
{
  flake-file.inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.policies.default-profile-to-programs =
    { host, ... }:
    [
      (den.lib.policy.route {
        fromClass = "zen-profile";
        intoClass = host.class;
        path = [
          "programs"
          "zen-browser"
          "profiles"
          "default"
        ];
      })
    ];

  den.default.includes = [ den.policies.default-profile-to-programs ];

  den.aspects.zen.default = {
    nixos =
      { isPersistent, user, ... }:
      lib.optional isPersistent {
        environment.persistence."/nix/persist".users."${user.name}".directories = lib.mkAfter [
          ".cache/zen"
          ".config/zen"
        ];
      };

    homeManager =
      {
        config,
        inputs,
        pkgs,
        ...
      }:
      {
        imports = [ inputs.zen-browser.homeModules.beta ];
        home.file.".zen".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/zen";

        programs.zen-browser = {
          enable = true;
          setAsDefaultBrowser = true;
          nativeMessagingHosts = with pkgs; [ kdePackages.plasma-browser-integration ];
          languagePacks = [ "es-ES" ];
          profiles.default = {
            id = 0;
            isDefault = true;
            name = "default";
            spacesForce = true;
            pinsForce = true;
            spaces.Default = {
              id = "1d674ff6-8b4f-4cfb-9635-c7d569280a0b";
              icon = "";
              position = 1000;
              theme = {
                colors = [
                  {
                    red = 63;
                    green = 3;
                    blue = 10;
                    algorithm = "floating";
                    type = "explicit-lightness";
                  }
                ];
                opacity = 0.9;
                texture = 0.5;
              };
            };
          };
        };
      };
  };
}

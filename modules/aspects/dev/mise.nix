{ lib, ... }:
{
  den.aspects.dev.mise = {
    nixos =
      { isPersistent, user, ... }:
      lib.optional isPersistent {
        environment.persistence."/nix/persist".users."${user}".directories = lib.mkAfter [
          ".cache/mise"
          ".local/share/mise"
          ".cargo"
          ".rustup"
        ];
      };
    homeManager.programs.mise = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      globalConfig = {
        tools = {
          bun = "1.3";
          node = "24";
        };
        settings = {
          trusted_config_paths = [ "~/repositories" ];
          node.compile = false;
          npm.bun = true;
        };
      };
    };
  };
}

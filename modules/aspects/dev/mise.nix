{
  den.aspects.dev.provides.mise.homeManager.programs.mise = {
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
}

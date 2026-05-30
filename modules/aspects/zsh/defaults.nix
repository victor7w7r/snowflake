{ den, ... }:
{
  den.aspects.zsh = {
    includes = with den.aspects.zsh._; [
      abbr
      aliases
      init
      options
      plugins
      variables

      bofh
      kaomoji
      misc
      node
      quotes
      utils
    ];

    nixos =
      { user, ... }:
      {
        environment = {
          pathsToLink = [ "/share/zsh" ];
          persistence."/nix/persist".users."${user}" = {
            files = [ ".zsh_history" ];
            directories = [
              ".cache/antidote"
              ".zsh"
            ];
          };
        };
      };

    homeManager.programs.zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      autosuggestion.enable = true;

      syntaxHighlighting = {
        enable = true;
        styles = {
          "alias" = "fg=magenta,bold";
          "command" = "fg=cyan";
        };
      };
      history = {
        extended = true;
        path = "$HOME/.zsh_history";
        save = 10000;
        size = 10000;
        share = true;
      };
      dirHashes = {
        docs = "$HOME/Documentos";
      };
      cdpath = [ "~/repositories/snowflake" ];
    };
  };
}

{ den, lib, ... }:
{
  den.aspects.bash = {
    includes = with den.aspects.bash._; [
      aliases
      init
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
        environment.persistence."/nix/persist".users."${user}".files = lib.mkAfter [ ".bash_history" ];
      };
    homeManager.programs.bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      historyControl = [ "erasedups" ];
      historyFileSize = 1000000;
      historySize = 10000;
      historyIgnore = [
        "ls"
        "cd"
        "exit"
      ];
    };
  };
}

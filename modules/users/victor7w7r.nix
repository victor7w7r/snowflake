{ lib, ... }:
{
  den.aspects.victor7w7r = {
    user =
      { pkgs, ... }:
      {
        initialHashedPassword = "$6$rZhNhLxPNJx.lRBn$lXAcMr7CdFgjRcN4ZMlEai2QYWMoawm6pMKrd9oFHXgWks9KBkP3p7Afj/Djj1LnCDyXbLNT5IfVNjDEUzk1p0";
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGTZ3iQqtjrClKVnqQ0w9Yn2sUoE9lAAW8ZYhR45nV5 arkano036@gmail.com"
        ];
      };

    homeManager = {
      home = {
        stateVersion = lib.mkDefault "25.05";
        sessionPath = [ "$HOME/.local/bin" ];
      };
    };
  };
}

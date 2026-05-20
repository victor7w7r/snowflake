{ ... }:
{
  den.hosts = {
    x86_64-linux = {
      live.users.snowflake = { };
      main.users.victor7w7r = { };
      handheld.users.victor7w7r = { };
      server.users.victor7w7r = { };
    };

    aarch64-linux = {
      pizero.users.victor7w7r = { };
      phone.users.victor7w7r = { };
      superlab.users.victor7w7r = { };
    };

    x86_64-darwin.main = {
      users.victor7w7r = { };
      #brew.apps = [ "iterm2" ];
    };
  };
}

{
  inputs,
  username,
  host,
  pkgs,
  system,
  self,
  ...
}:
let
  homeConfig =
    {
      user ? "root",
    }:
    {
      programs.home-manager.enable = true;
      home = {
        username = user;
        homeDirectory = if user == "root" then "/root" else "/home/${user}";
      };

      imports = [
        (import ./system)
      ]
      ++ (
        if
          (host != "v7w7r-nixvm")
          && (host != "v7w7r-youyeetoox1")
          && (host != "v7w7r-opizero2w")
          && (host != "v7w7r-fajita")
          && (user != "root")
        then
          [
            (import ./misc)
            (import ./multimedia)
          ]
        else
          [ ]
      )
      ++ (
        if (host != "v7w7r-opizero2w" && host != "v7w7r-fajita") then
          [
            (import ./hardware)
            (import ./networking)
          ]
        else
          [ ]
      )
      ++ (
        if (user != "root") then
          [
            (import ./desktop)
            (import ./dev)
            (import ./hardware)
            (import ./networking)
            (import ./zen)
          ]
        else
          [ ]
      );

    };
in
{
  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        username
        host
        system
        self
        ;
    };
    users = {
      ${username} = homeConfig { user = username; };
      root = homeConfig { };
    };
  };
}

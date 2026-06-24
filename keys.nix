let
  macmini = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOcaIHU3IokpzFxak5YxCtnBQ5t4v7xC9sJagepHlLjZ arkano036@gmail.com";
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK5DdggFsOQJ2Rh7Q0Gxm73V+QhTmSDeyczASVvrdMn5 arkano036@gmail.com";
  rogally = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBNkXfjC3QM0xSle1LkxySgKg/ddsN6YAcp/5Lufo1v4 arkano036@gmail.com";
  opizero = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAn3nBXA6K2kTnTMSk5/Fhl2TgCCffWybPqpol/8mc1P arkano036@gmail.com";

  user-macmini = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGTZ3iQqtjrClKVnqQ0w9Yn2sUoE9lAAW8ZYhR45nV5 arkano036@gmail.com";
  user-server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtujbHCddsta3Oky+aBF8HVBIE6yOPGNss8o5fSrMLe arkano036@gmail.com";
  user-rogally = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKXqgBzeyPlT4h+2OGnZobsVj24gyEmgLLqNLAA/D3Qo arkano036@gmail.com";
  user-opizero = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDtH26q1AfO+AHd84H9L+a8FB28xfMIJLJgsCjgYWebi arkano036@gmail.com";

  systems = [
    macmini
    server
    rogally
    opizero
  ];

  users = [
    user-macmini
    user-server
    user-rogally
    user-opizero
  ];
in
{
  #nix run github:ryantm/agenix -- -e ...
  "secrets/seckey-a.age".publicKeys = systems ++ users;
  "secrets/seckey-b.age".publicKeys = systems ++ users;
  "secrets/seckey-c.age".publicKeys = systems ++ users;
  "secrets/seckey-d.age".publicKeys = systems ++ users;
  "modules/core/selfhost/secrets/password-db.age".publicKeys = systems ++ users;
  "modules/core/selfhost/secrets/tailnet.age".publicKeys = systems ++ users;
  "modules/core/selfhost/secrets/seafile-db-env.age".publicKeys = systems ++ users;
  "modules/core/selfhost/secrets/seafile-env.age".publicKeys = systems ++ users;
  "modules/core/selfhost/secrets/tunnel.age".publicKeys = systems ++ users;
  "modules/core/selfhost/secrets/cloudflare-token.age".publicKeys = systems ++ users;
}

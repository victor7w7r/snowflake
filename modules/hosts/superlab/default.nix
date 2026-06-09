{ den, inputs, ... }:
{
  imports = [ (inputs.den.namespace "superlab" false) ];

  den = {
    hosts.aarch64-linux.superlab = {
      hostName = "v7w7r-radxarock5b";
      users.victor7w7r = { };
    };

    aspects.superlab = {
      includes = with den.aspects; [
        base._
        base.tmux._
        base.shell._
        dev._
        gui._
        initrd._
        networking._
        nix._
        plasma._
        sound._
        tweaks._
        users._
        vim._
        virtualisation._
        zen._

        android
        bluetooth
        btrfs
        fetch
        forensics
        hardware
        kitty
        secrets
        zed
      ];

      nixos = {
      };
    };
  };
}

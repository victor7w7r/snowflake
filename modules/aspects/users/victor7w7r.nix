{
  den,
  inputs,
  lib,
  ...
}:
{
  den.aspects.victor7w7r = {
    includes = [
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")
    ];

    provides.to-hosts = {
      nixos =
        { pkgs, ... }:
        {
          imports = [ inputs.home-manager.nixosModules.home-manager ];
          home-manager = {
            backupCommand = "${pkgs.trash-cli}/bin/trash";
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm-backup";
          };
        };
    };

    user =
      { pkgs, ... }:
      {
        description = "victor7w7r";
        linger = true;
        #root.hashedPassword = "$y$j9T$ieUYJ2thSsvR1M37kWe651$yt0z7Ga3..johS8fyA1Y9GaoddW.jfE838xXiFhcus1";
        hashedPassword = "$y$j9T$ieUYJ2thSsvR1M37kWe651$yt0z7Ga3..johS8fyA1Y9GaoddW.jfE838xXiFhcus1";
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGTZ3iQqtjrClKVnqQ0w9Yn2sUoE9lAAW8ZYhR45nV5 arkano036@gmail.com"
        ];
        /*
          autoSubUidGidRange = false;
          group = "users";
          uid = 1000;
          subUidRanges = [
            {
              startUid = 100000;
              count = 65536;
            }
          ];
          subGidRanges = [
            {
              startGid = 100000;
              count = 65536;
            }
          ];
        */
        extraGroups = [
          "audio"
          "gamemode"
          "input"
          "kvm"
          "adbusers"
          "dialout"
          "libvirtd"
          "libvirt-qemu"
          "power"
          "qemu"
          "qemu-libvirtd"
          "plugdev"
          "realtime"
          "storage"
          "tty"
          "users"
          "wheel"
        ];
      };

    homeManager =
      { config, ... }:
      {
        home = {
          stateVersion = lib.mkDefault "26.05";
          sessionPath = [ "$HOME/.local/bin" ];
          file."repositories/nixstrap".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
        };
      };
  };
}

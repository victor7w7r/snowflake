{
  pkgs,
  username,
  ...
}:
{
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users = {
      root.hashedPassword = "$y$j9T$ieUYJ2thSsvR1M37kWe651$yt0z7Ga3..johS8fyA1Y9GaoddW.jfE838xXiFhcus1";
      "${username}" = {
        autoSubUidGidRange = false;
        description = "${username}";
        group = "users";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGTZ3iQqtjrClKVnqQ0w9Yn2sUoE9lAAW8ZYhR45nV5 arkano036@gmail.com"
        ];
        hashedPassword = "$y$j9T$ieUYJ2thSsvR1M37kWe651$yt0z7Ga3..johS8fyA1Y9GaoddW.jfE838xXiFhcus1";
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
        extraGroups = [
          "audio"
          "gamemode"
          "input"
          "kvm"
          "adbusers"
          "dialout"
          "libvirtd"
          "libvirt-qemu"
          "networkmanager"
          "power"
          "qemu"
          "qemu-libvirtd"
          "plugdev"
          "realtime"
          "storage"
          "tty"
          "users"
          "video"
          "wheel"
        ];
      };
    };
  };

  /*
    // (
      if host == "v7w7r-youyeetoox1" then
        {
          etc."intel-undervolt.conf".text = ''
            power package 8 28 10 2.4
          '';
        }
      else
        { }
    );
  */

  /*
    // (
    if host != "v7w7r-opizero2w" then
      {
        appimage = {
          enable = true;
          binfmt = true;
        };
      }
    else
      { }
      );
  */
}

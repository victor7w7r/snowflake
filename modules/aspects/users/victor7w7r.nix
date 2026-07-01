{
  den.aspects.victor7w7r.user = {
    description = "victor7w7r";
    linger = true;
    #root.hashedPassword = "$y$j9T$ieUYJ2thSsvR1M37kWe651$yt0z7Ga3..johS8fyA1Y9GaoddW.jfE838xXiFhcus1";
    hashedPassword = "$y$j9T$ieUYJ2thSsvR1M37kWe651$yt0z7Ga3..johS8fyA1Y9GaoddW.jfE838xXiFhcus1";
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
      "adbusers"
      "audio"
      "dialout"
      "gamemode"
      "input"
      "kvm"
      "libvirt-qemu"
      "libvirtd"
      "plugdev"
      "power"
      "qemu"
      "qemu-libvirtd"
      "realtime"
      "storage"
      "tty"
      "video"
    ];
  };
}

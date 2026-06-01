{
  den.aspects.initrd-systemd.nixos =
    { pkgs, ... }:
    {
      boot.initrd.systemd = {
        enable = true;
        emergencyAccess = true;
        users.root.shell = "${pkgs.bashInteractive}/bin/bash";
        contents = {
          "/etc/ssl/certs/ca-certificates.crt".source = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
          #"/etc/terminfo".source = "${pkgs.ncurses}/share/terminfo";
        };
        settings.Manager = {
          DefaultTimeoutStartSec = "15s";
          DefaultTimeoutStopSec = "10s";
          DefaultTimeoutAbortSec = "5s";
          DefaultLimitNOFILE = "2048:2097152";
        };
        initrdBin = with pkgs; [ coreutils ];
        storePaths = with pkgs; [
          "${bashInteractive}/bin/bash"
          util-linux
          ncurses
        ];
        extraBin = with pkgs; {
          nix = "${nix}/bin/nix";
          ip = "${iproute2}/bin/ip";
          curl = "${curl}/bin/curl";
          ping = "${iputils}/bin/ping";
          cryptsetup = "${cryptsetup}/bin/cryptsetup";
          busybox = "${busybox-sandbox-shell}/bin/busybox";
          htop = "${htop}/bin/htop";
          yazi = "${yazi-unwrapped}/bin/yazi";
          find = "${findutils}/bin/find";
          fdisk = "${util-linux}/bin/fdisk";
          file = "${file}/bin/file";
          blkid = "${util-linux}/bin/blkid";
          lsblk = "${util-linux}/bin/lsblk";
          lspci = "${pciutils}/bin/lspci";
          grep = "${gnugrep}/bin/grep";
        };
      };
    };
}

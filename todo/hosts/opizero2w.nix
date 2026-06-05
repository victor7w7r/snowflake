{
  config,
  pkgs,
  kernelData,
  ...
}:
let
  #uboot = import ./custom/sunxi-uboot.nix { inherit pkgs; };
  f2fs = import ./lib/f2fs.nix;
  kernel = (pkgs.callPackage ../kernel/sunxi) { inherit kernelData; };
  #cp ${uboot}/u-boot-sunxi-with-spl.bin $out/
  bootFiles = ''
    mkdir -p boot
    ${config.boot.loader.generic-extlinux-compatible.populateCmd} \
      -c ${config.system.build.toplevel} -d boot
    tar -cv -C . boot | zstd -T$NIX_BUILD_CORES > $out/boot.tar.zst
  '';
in
{
  nixpkgs.overlays = [
    (_final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  system.build.bootFiles =
    pkgs.runCommand "boot-files" { nativeBuildInputs = with pkgs; [ zstd ]; }
      ''
        mkdir -p $out
        ${bootFiles}
      '';

  imports = [
    /*
      (import ./soc {
      inherit config pkgs host;
      postBuildCommands = "dd if=${uboot}/u-boot-sunxi-with-spl.bin of=boot.img bs=1024 seek=8 conv=notrunc";
      populateFirmwareCommands = ''
        mkdir -p firmware/boot
        ${config.boot.loader.generic-extlinux-compatible.populateCmd} \
          -c ${config.system.build.toplevel} -d firmware/boot
      '';
      })
    */

    (import ./lib/tarball.nix {
      inherit config pkgs;
      additionalContent = bootFiles;
    })
  ];

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=2G"
        "mode=755"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [
        "nofail"
        "noauto"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-label/store";
      neededForBoot = true;
      fsType = "xfs";
      options = [
        "noatime"
        "nodiratime"
        "lazytime"
        "logbufs=8"
        "logbsize=256k"
      ];
    };
    "/nix/persist" = f2fs {
      label = "persist";
      device = "/dev/disk/by-label/persist";
      depends = [ "/nix" ];
    };
  };

  boot = {
    kernelParams = [
      "earlycon"
      "console=ttyS0,115200n8"
    ];
    initrd = {
      network.enable = true;
      verbose = true;
      systemd = {
        enable = true;
        emergencyAccess = true;
        users.root.shell = "${pkgs.bashInteractive}/bin/bash";
        contents = {
          "/share/terminfo".source = "${pkgs.ncurses}/share/terminfo";
          "/etc/ssl/certs/ca-certificates.crt".source = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
        };
        initrdBin = with pkgs; [
          coreutils
          iproute2
          vim
          bashInteractive
        ];
        storePaths = with pkgs; [
          mtdutils
          util-linux
          "${ncurses}/bin/clear"
          "${bashInteractive}/bin/bash"
        ];
        settings.Manager = {
          DefaultTimeoutStartSec = "15s";
          DefaultTimeoutStopSec = "10s";
          DefaultTimeoutAbortSec = "5s";
          DefaultLimitNOFILE = "2048:2097152";
        };
        extraBin = {
          nix = "${pkgs.nix}/bin/nix";
          ip = "${pkgs.iproute2}/bin/ip";
          curl = "${pkgs.curl}/bin/curl";
          ping = "${pkgs.iputils}/bin/ping";
          cryptsetup = "${pkgs.cryptsetup}/bin/cryptsetup";
          efibootmgr = "${pkgs.efibootmgr}/bin/efibootmgr";
          busybox = "${pkgs.busybox}/bin/busybox";
          htop = "${pkgs.htop}/bin/htop";
          yazi = "${pkgs.yazi-unwrapped}/bin/yazi";
          find = "${pkgs.findutils}/bin/find";
          fdisk = "${pkgs.util-linux}/bin/fdisk";
          file = "${pkgs.file}/bin/file";
          lshw = "${pkgs.lshw}/bin/lshw";
          lsusb = "${pkgs.usbutils}/bin/lsusb";
          blkid = "${pkgs.util-linux}/bin/blkid";
          lsblk = "${pkgs.util-linux}/bin/lsblk";
          lspci = "${pkgs.pciutils}/bin/lspci";
          grep = "${pkgs.gnugrep}/bin/grep";
        };
      };
      kernelModules = [
        "g_ether"
        "sdhci"
        "sdhci_pci"
        "uas"
        "sunxi_gmac"
        "libcomposite"
      ];
    };
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    extraModprobeConfig = "options zram num_devices=1";
    kernelPackages = kernel.packages;
  };

  networking.wireless.enable = true;
  systemd.tmpfiles.rules = [
    "L+ /lib/firmware - - - - /run/current-system/firmware"
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 100;
  };

  hardware = {
    deviceTree = {
      enable = true;
      name = "allwinner/sun50i-h618-orangepi-zero2w.dtb";
    };
  };
}

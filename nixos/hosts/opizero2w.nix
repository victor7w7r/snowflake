{
  config,
  pkgs,
  kernelData,
  ...
}:
let
  uboot = import ./custom/sunxi-uboot.nix { inherit pkgs; };
  f2fs = import ./lib/f2fs.nix;
  kernel = (pkgs.callPackage ../kernel/sunxi) { inherit kernelData; };
in
{
  nixpkgs.overlays = [
    (_final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

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
      additionalContent = ''
        cp ${uboot}/u-boot-sunxi-with-spl.bin $out/
        mkdir -p boot
        ${config.boot.loader.generic-extlinux-compatible.populateCmd} \
          -c ${config.system.build.toplevel} -d boot
        tar -cv -C . boot | zstd -T$NIX_BUILD_CORES > $out/boot.tar.zst
      '';
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
        "commit=60"
        "barrier=0"
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
      "systemd.setenv=SYSTEMD_SULOGIN_FORCE=1"
    ];
    initrd = {
      systemd.contents."/share/terminfo".source = "${pkgs.ncurses}/share/terminfo";
      kernelModules = [
        "sunxi-mmc"
        "usb_storage"
        "uas"
        "g_ether"
        "uhci_hcd"
        "ehci_hcd"
        "xhci_pci"
        "xhci_pci"
        "usbhid"
        "sun8i-rsb"
        "phy_sun4i_usb"
        "ohci_sunxi"
        "ehci_sunxi"
        "axp20x_rsb"
        "axp20x_regulator"
        "sprdbt_tty"
        "sdhci_pci"
        "sdhci_acpi"
        "sdhci"
        "uwe5622_bsp_sdio"
        "libcomposite"
        "sprdwl_ng"
        "mmc_block"
        "nvmem_sunxi_sid"
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
      overlays = [
        {
          name = "h616-gpu";
          dtbo = "allwinner/overlays/sun50i-h616-gpu.dtbo";
        }
        {
          name = "h616-i2c0";
          dtbo = "allwinner/overlays/sun50i-h616-i2c0-pi.dtbo";
        }
        {
          name = "h616-i2c1";
          dtbo = "allwinner/overlays/sun50i-h616-i2c1-pi.dtbo";
        }
        {
          name = "h616-i2c2-ph";
          dtbo = "allwinner/overlays/sun50i-h616-i2c2-ph.dtbo";
        }
        {
          name = "h616-i2c2-pi";
          dtbo = "allwinner/overlays/sun50i-h616-i2c2-pi.dtbo";
        }
        {
          name = "h616-i2c3-pg";
          dtbo = "allwinner/overlays/sun50i-h616-i2c3-pg.dtbo";
        }
        {
          name = "h616-i2c3-ph";
          dtbo = "allwinner/overlays/sun50i-h616-i2c3-ph.dtbo";
        }
        {
          name = "h616-i2c4-pg";
          dtbo = "allwinner/overlays/sun50i-h616-i2c4-pg.dtbo";
        }
        {
          name = "h616-i2c4-ph";
          dtbo = "allwinner/overlays/sun50i-h616-i2c4-ph.dtbo";
        }
        {
          name = "h616-ir";
          dtbo = "allwinner/overlays/sun50i-h616-ir.dtbo";
        }
        {
          name = "h616-keys";
          dtbo = "allwinner/overlays/sun50i-h616-keys.dtbo";
        }
        {
          name = "h616-light";
          dtbo = "allwinner/overlays/sun50i-h616-light.dtbo";
        }
        {
          name = "h616-mcp2515";
          dtbo = "allwinner/overlays/sun50i-h616-mcp2515.dtbo";
        }
        {
          name = "h616-pwm1-ph3";
          dtbo = "allwinner/overlays/sun50i-h616-pwm1-ph3.dtbo";
        }
        {
          name = "h616-pwm1-pi11";
          dtbo = "allwinner/overlays/sun50i-h616-pwm1-pi11.dtbo";
        }
        {
          name = "h616-pwm2-ph2";
          dtbo = "allwinner/overlays/sun50i-h616-pwm2-ph2.dtbo";
        }
        {
          name = "h616-pwm2-pi12";
          dtbo = "allwinner/overlays/sun50i-h616-pwm2-pi12.dtbo";
        }
        {
          name = "h616-pwm3-ph0";
          dtbo = "allwinner/overlays/sun50i-h616-pwm3-ph0.dtbo";
        }
        {
          name = "h616-pwm3-pi13";
          dtbo = "allwinner/overlays/sun50i-h616-pwm3-pi13.dtbo";
        }
        {
          name = "h616-pwm4-ph1";
          dtbo = "allwinner/overlays/sun50i-h616-pwm4-ph1.dtbo";
        }
        {
          name = "h616-pwm4-pi14";
          dtbo = "allwinner/overlays/sun50i-h616-pwm4-pi14.dtbo";
        }
        {
          name = "h616-spidev0_0";
          dtbo = "allwinner/overlays/sun50i-h616-spidev0_0.dtbo";
        }
        {
          name = "h616-spidev1_0";
          dtbo = "allwinner/overlays/sun50i-h616-spidev1_0.dtbo";
        }
        {
          name = "h616-spidev1_1";
          dtbo = "allwinner/overlays/sun50i-h616-spidev1_1.dtbo";
        }
        {
          name = "h616-spidev1_2";
          dtbo = "allwinner/overlays/sun50i-h616-spidev1_2.dtbo";
        }
        {
          name = "h616-spidev";
          dtbo = "allwinner/overlays/sun50i-h616-spi-spidev.dtbo";
        }
        {
          name = "h616-tft35_spi";
          dtbo = "allwinner/overlays/sun50i-h616-tft35_spi.dtbo";
        }
        {
          name = "h616-uart2-pg";
          dtbo = "allwinner/overlays/sun50i-h616-uart2-pg.dtbo";
        }
        {
          name = "h616-uart2-pg-rts-cts";
          dtbo = "allwinner/overlays/sun50i-h616-uart2-pg-rts-cts.dtbo";
        }
        {
          name = "h616-uart2-ph";
          dtbo = "allwinner/overlays/sun50i-h616-uart2-ph.dtbo";
        }
        {
          name = "h616-uart2-ph-rts-cts";
          dtbo = "allwinner/overlays/sun50i-h616-uart2-ph-rts-cts.dtbo";
        }
        {
          name = "h616-uart2-pi";
          dtbo = "allwinner/overlays/sun50i-h616-uart2-pi.dtbo";
        }
        {
          name = "h616-uart2-pi-rts-cts";
          dtbo = "allwinner/overlays/sun50i-h616-uart2-pi-rts-cts.dtbo";
        }
        {
          name = "h616-uart3-pi";
          dtbo = "allwinner/overlays/sun50i-h616-uart3-pi.dtbo";
        }
        {
          name = "h616-uart3-pi-rts-cts";
          dtbo = "allwinner/overlays/sun50i-h616-uart3-pi-rts-cts.dtbo";
        }
        {
          name = "h616-uart4-pi";
          dtbo = "allwinner/overlays/sun50i-h616-uart4-pi.dtbo";
        }
        {
          name = "h616-uart4-pi-rts-cts";
          dtbo = "allwinner/overlays/sun50i-h616-uart4-pi-rts-cts.dtbo";
        }
        {
          name = "h616-uart5";
          dtbo = "allwinner/overlays/sun50i-h616-uart5.dtbo";
        }
        {
          name = "h616-ws2812";
          dtbo = "allwinner/overlays/sun50i-h616-ws2812.dtbo";
        }
      ];
    };
  };
}

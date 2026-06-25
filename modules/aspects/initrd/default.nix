{ lib, ... }:
{
  den.aspects.initrd.default.nixos =
    {
      isIntel,
      isLive,
      hasVisualKeyboard,
      pkgs,
      ...
    }:
    {
      boot = {
        supportedFilesystems = [
          "btrfs"
          "ext4"
          "exfat"
          "f2fs"
          "ntfs"
          "vfat"
        ]
        ++ lib.optionals isIntel [ "xfs" ]
        ++ lib.optionals (isLive || hasVisualKeyboard) [ "bcachefs" ];

        consoleLogLevel = 4;
        modprobeConfig.enable = true;
        kernelParams = [ "lsm=landlock,yama,integrity,apparmor,bpf" ];
        tmp = {
          cleanOnBoot = true;
          useTmpfs = true;
        };
        kernelPatches = [
          {
            name = "nixos-systemd-structured-required";
            patch = null;
            structuredExtraConfig = with pkgs.lib.kernel; {
              DEVTMPFS = yes;
              DEVTMPFS_MOUNT = yes;
              CGROUPS = yes;
              INOTIFY_USER = yes;
              SIGNALFD = yes;
              TIMERFD = yes;
              EPOLL = yes;
              SYSFS = yes;
              PROC_FS = yes;
              FHANDLE = yes;
              BINFMT_ELF = yes;
              BLK_DEV_INITRD = yes;
              NET = yes;
              UNIX = yes;
              SWAP = yes;
              TMPFS = yes;
              TMPFS_POSIX_ACL = yes;
              TMPFS_XATTR = yes;
              SECCOMP = yes;
              CRYPTO_USER_API_HASH = yes;
              CRYPTO_HMAC = yes;
              CRYPTO_SHA256 = yes;
              AUTOFS_FS = yes;
              ZRAM = yes;
            };
          }
        ];
        extraModprobeConfig = ''
          blacklist iTCO_wdt
          blacklist joydev
          blacklist mousedev
          blacklist mac_hid
          blacklist intel_hid
        '';
        initrd = {
          /*
            availableKernelModules = [
              "autofs"
              "dm-thin-pool"
              "dm-snapshot"
              "tpm_tis"
              "tpm_crb"
            ];
            kernelModules = [
                "tcp_bbr"
                "dm-thin-pool"
                "veth"
                "xt_comment"
                "xt_CHECKSUM"
                "xt_MASQUERADE"
                "vhost_vsock"
                "iptable_mangle"
              ];
              }
          */

          checkJournalingFS = true;
          services.lvm.enable = true;
          compressorArgs = [
            "-19"
            "--ultra"
            "-T0"
            "--check"
          ];
          network.enable = true;
          verbose = true;
        };
      };
    };
}

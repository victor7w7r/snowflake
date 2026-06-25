{
  kernel.config.modules.essentials = {
    DEVTMPFS = "y";
    DEVTMPFS_MOUNT = "y";
    CGROUPS = "y";
    INOTIFY_USER = "y";
    SIGNALFD = "y";
    TIMERFD = "y";
    EPOLL = "y";
    SYSFS = "y";
    PROC_FS = "y";
    FHANDLE = "y";
    BINFMT_ELF = "y";
    BLK_DEV_INITRD = "y";
    NET = "y";
    UNIX = "y";
    SWAP = "y";
    TMPFS = "y";
    TMPFS_POSIX_ACL = "y";
    TMPFS_XATTR = "y";
    SECCOMP = "y";
    CRYPTO_USER_API_HASH = "y";
    CRYPTO_HMAC = "y";
    CRYPTO_SHA256 = "y";
    DMIID = "y";
    AUTOFS_FS = "y";
    ZRAM = "y";
  };
}

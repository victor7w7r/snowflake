{
  kernel.config.modules.storage = {
    bcachefs = {
      BCACHEFS_FS = "y";
      BCACHEFS_QUOTA = "y";
      BCACHEFS_ERASURE_CODING = "y";
      BCACHEFS_POSIX_ACL = "y";
      BCACHEFS_LOCK_TIME_STATS = "y";
      BCACHEFS_SIX_OPTIMISTIC_SPIN = "y";
      BCACHEFS_PATH_TRACEPOINTS = "y";
    };

    not-btrfs = {
      BTRFS_FS = "n";
    };

    not-cdrom = {
      CDROM = "n";
      UDF_FS = "n";
    };

    f2fs = {
      F2FS_FS = "y";
    };

    not-f2fs = {
      F2FS_FS = "n";
    };

    not-mmc = {
      MMC = "n";
      MMC_BLOCK = "n";
    };

    mmc = {
      MMC = "y";
      MMC_BLOCK = "y";
    };

    ntfs = {
      NTFS3_FS = "m";
      NTFS3_LZX_XPRESS = "y";
      NTFS3_FS_POSIX_ACL = "y";
    };

    not-ntfs = {
      NTFS3_FS = "n";
    };

    raid = {
      BLK_DEV_DM = "y";
    };

    not-raid = {
      MD = "n";
    };

    xfs = {
      XFS_FS = "y";
    };

    not-xfs = {
      XFS_FS = "n";
    };
  };
}

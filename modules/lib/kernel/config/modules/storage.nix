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
      BTRFS_FS_POSIX_ACL = "n";
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
      F2FS_STAT_FS = "n";
      F2FS_FS_XATTR = "n";
      F2FS_FS_POSIX_ACL = "n";
      F2FS_FS_SECURITY = "n";
      F2FS_CHECK_FS = "n";
      F2FS_FS_COMPRESSION = "n";
      F2FS_FS_LZO = "n";
      F2FS_FS_LZORLE = "n";
      F2FS_FS_LZ4 = "n";
      F2FS_FS_LZ4HC = "n";
      F2FS_FS_ZSTD = "n";
      F2FS_IOSTAT = "n";
      F2FS_UNFAIR_RWSEM = "n";
    };

    ntfs = {
      NTFS3_FS = "m";
      NTFS3_LZX_XPRESS = "y";
      NTFS3_FS_POSIX_ACL = "y";
    };

    not-ntfs = {
      NTFS3_FS = "n";
      NTFS3_LZX_XPRESS = "n";
      NTFS3_FS_POSIX_ACL = "n";
    };

    not-raid = {
      MD = "n";
      BLK_DEV_MD = "n";
      MD_BITMAP = "n";
      MD_BITMAP_FILE = "n";
      MD_LINEAR = "n";
      MD_LLBITMAP = "n";
      MD_RAID0 = "n";
      MD_RAID1 = "n";
      MD_RAID10 = "n";
      MD_RAID456 = "n";
    };

    xfs = {
      XFS_FS = "y";
    };

    not-xfs = {
      XFS_FS = "n";
      XFS_SUPPORT_V4 = "n";
      XFS_SUPPORT_ASCII_CI = "n";
      XFS_POSIX_ACL = "n";
      XFS_RT = "n";
      XFS_DRAIN_INTENTS = "n";
      XFS_LIVE_HOOKS = "n";
      XFS_MEMORY_BUFS = "n";
      XFS_BTREE_IN_MEM = "n";
      XFS_ONLINE_SCRUB = "n";
      XFS_ONLINE_REPAIR = "n";
    };
  };
}

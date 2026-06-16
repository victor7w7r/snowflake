{
  kernel.config.modules.fs = {
    bcachefs = {
      BCACHEFS_FS = "y";
      BCACHEFS_QUOTA = "y";
      BCACHEFS_ERASURE_CODING = "y";
      BCACHEFS_POSIX_ACL = "y";
      BCACHEFS_LOCK_TIME_STATS = "y";
      BCACHEFS_SIX_OPTIMISTIC_SPIN = "y";
      BCACHEFS_PATH_TRACEPOINTS = "y";
    };

    overlayfs = {
      OVERLAY_FS = "y";
      OVERLAY_FS_REDIRECT_DIR = "y";
      OVERLAY_FS_INDEX = "y";
      OVERLAY_FS_XINO_AUTO = "y";
    };

    f2fs = {
      F2FS_FS = "y";
      F2FS_CHECK_FS = "y";
      F2FS_FS_COMPRESSION = "y";
      F2FS_FS_LZ4 = "y";
      F2FS_FS_LZ4HC = "y";
      F2FS_FS_SECURITY = "y";
      F2FS_FS_ZSTD = "y";
    };

    xfs = {
      XFS_FS = "y";
      XFS_SUPPORT_V4 = "y";
      XFS_SUPPORT_ASCII_CI = "y";
      XFS_QUOTA = "y";
      XFS_POSIX_ACL = "y";
      XFS_RT = "y";
      XFS_DRAIN_INTENTS = "y";
      XFS_LIVE_HOOKS = "y";
      XFS_MEMORY_BUFS = "y";
      XFS_BTREE_IN_MEM = "y";
      XFS_ONLINE_SCRUB = "y";
      XFS_ONLINE_REPAIR = "y";
    };
  };
}

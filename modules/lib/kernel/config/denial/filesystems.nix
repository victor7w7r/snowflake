{
  kernel.config.denial.filesystems = rec {
    all = fs // label // nls;

    fs = {
      AFFS_FS = "n";
      AFS_FS = "n";
      BEFS_FS = "n";
      CODA_FS = "n";
      CRAMFS = "n";
      CUSE = "n";
      EROFS_FS = "n";
      GFS2_FS = "n";
      HFSPLUS_FS = "n";
      HFS_FS = "n";
      JFS_FS = "n";
      MINIX_FS = "n";
      NILFS2_FS = "n";
      NTFS_FS = "n";
      OCFS2_FS = "n";
      OMFS_FS = "n";
      ORANGEFS_FS = "n";
      ROMFS_FS = "n";
      UFS_FS = "n";
      ZONEFS_FS = "n";
      QUOTA = "n";
      TMPFS_QUOTA = "n";
      XFS_QUOTA = "n";
    };

    label = {
      AIX_PARTITION = "n";
      BSD_DISKLABEL = "n";
      KARMA_PARTITION = "n";
      LDM_PARTITION = "n";
      MAC_PARTITION = "n";
      MINIX_SUBPARTITION = "n";
      SOLARIS_X86_PARTITION = "n";
    };

    nls = {
      DLM = "n";
      NLS_UTF8 = "n";
      NLS_KOI8_R = "n";
      NLS_KOI8_U = "n";
      NLS_UCS2_UTILS = "n";
    };
  };
}

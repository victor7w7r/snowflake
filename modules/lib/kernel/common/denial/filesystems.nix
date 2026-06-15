{
  kernel.lib.denial.filesystems = rec {
    all = fs // label;

    fs = {
      "9P_FS" = "n";
      AFFS_FS = "n";
      AFS_FS = "n";
      BEFS_FS = "n";
      CODA_FS = "n";
      CRAMFS = "n";
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
    };

    label = {
      AIX_PARTITION = "n";
      BSD_DISKLABEL = "n";
      LDM_PARTITION = "n";
      MAC_PARTITION = "n";
    };
  };
}

{
  kernel.config.denial.filesystems = rec {
    all = fs // label // nls // quota;

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

    quota = {
      QUOTA = "n";
      TMPFS_QUOTA = "n";
      XFS_QUOTA = "n";
    };

    nls = {
      DLM = "n";
      NLS_CODEPAGE_1250 = "n";
      NLS_CODEPAGE_1251 = "n";
      NLS_CODEPAGE_737 = "n";
      NLS_CODEPAGE_775 = "n";
      NLS_CODEPAGE_850 = "n";
      NLS_CODEPAGE_852 = "n";
      NLS_CODEPAGE_855 = "n";
      NLS_CODEPAGE_857 = "n";
      NLS_CODEPAGE_860 = "n";
      NLS_CODEPAGE_861 = "n";
      NLS_CODEPAGE_862 = "n";
      NLS_CODEPAGE_863 = "n";
      NLS_CODEPAGE_864 = "n";
      NLS_CODEPAGE_865 = "n";
      NLS_CODEPAGE_866 = "n";
      NLS_CODEPAGE_869 = "n";
      NLS_CODEPAGE_874 = "n";
      NLS_CODEPAGE_932 = "n";
      NLS_CODEPAGE_936 = "n";
      NLS_CODEPAGE_949 = "n";
      NLS_CODEPAGE_950 = "n";
      NLS_ISO8859_13 = "n";
      NLS_ISO8859_14 = "n";
      NLS_ISO8859_15 = "n";
      NLS_ISO8859_2 = "n";
      NLS_ISO8859_3 = "n";
      NLS_ISO8859_4 = "n";
      NLS_ISO8859_5 = "n";
      NLS_ISO8859_6 = "n";
      NLS_ISO8859_7 = "n";
      NLS_ISO8859_8 = "n";
      NLS_ISO8859_9 = "n";
      NLS_KOI8_R = "n";
      NLS_KOI8_U = "n";
      NLS_MAC_CELTIC = "n";
      NLS_MAC_CENTEURO = "n";
      NLS_MAC_CROATIAN = "n";
      NLS_MAC_CYRILLIC = "n";
      NLS_MAC_GAELIC = "n";
      NLS_MAC_GREEK = "n";
      NLS_MAC_ICELAND = "n";
      NLS_MAC_INUIT = "n";
      NLS_MAC_ROMAN = "n";
      NLS_MAC_ROMANIAN = "n";
      NLS_MAC_TURKISH = "n";
      NLS_UCS2_UTILS = "n";
      NLS_UTF8 = "n";
    };
  };
}

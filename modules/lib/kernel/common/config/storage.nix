{
  kernel.lib.config.storage = rec {
    all = raid // zram;

    raid = {
      MD = "y";
      BLK_DEV_MD = "y";
      MD_BITMAP = "y";
      MD_BITMAP_FILE = "y";
      MD_CLUSTER = "y";
      MD_LINEAR = "y";
      MD_LLBITMAP = "y";
      MD_RAID0 = "y";
      MD_RAID1 = "y";
      MD_RAID10 = "y";
      MD_RAID456 = "y";
    };

    zram = {
      CRYPTO_LZ4HC = "y";
      CRYPTO_LZ4 = "y";
      CRYPTO_LZO = "y";
      ZRAM = "m";
      ZRAM_DEF_COMP_LZ4 = "y";
      ZRAM_LZ4_COMPRESS = "y";
      ZRAM_BACKEND_842 = "n";
    };
  };
}

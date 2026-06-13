{
  kernel.lib.config.blacklist = rec {
    all = common // fs // label // virt // x86;

    common = {
      ATA_GENERIC = "n";
      CAN = "n";
      B43 = "n";
      B43LEGACY = "n";
      B44 = "n";
      B53 = "n";
      FIREWIRE = "n";
      INFINIBAND = "n";
      MOST = "n";
      MOUSE_PS2 = "n";
      MULTIPLEXER = "n";
      NFC = "n";
      NTB = "n";
      PATA = "n";
      PLIP = "n";
      PPP = "n";
      PATA_LEGACY = "n";
      STM = "n";
      SSB = "n";
    };

    fs = {
      "9P_FS" = "n";
      AFFS_FS = "n";
      AFS_FS = "n";
      BEFS_FS = "n";
      CODA_FS = "n";
      CRAMFS = "n";
      EROFS_FS = "n";
      GFS2_FS = "n";
      HFS_FS = "n";
      HFSPLUS_FS = "n";
      JFS_FS = "n";
      NTFS_FS = "n";
      NILFS2_FS = "n";
      ORANGEFS_FS = "n";
      OCFS2_FS = "n";
      ROMFS_FS = "n";
      UFS_FS = "n";
    };

    label = {
      AIX_PARTITION = "n";
      BSD_DISKLABEL = "n";
      LDM_PARTITION = "n";
      MAC_PARTITION = "n";
    };

    virt = {
      HYPERVISOR_GUEST = "n";
      KVM_XEN = "n";
      XEN = "n";
    };

    x86 = {
      X86_DECODER_SELFTEST = "n";
      X86_EXTENDED_PLATFORM = "n";
      X86_IOPL_IOPERM = "n";
      X86_MPPARSE = "n";
      X86_SGX = "n";
      X86_SGX_KVM = "n";
      X86_VSYSCALL_EMULATION = "n";
      X86_REROUTE_FOR_BROKEN_BOOT_IRQS = "n";
    };
  };
}

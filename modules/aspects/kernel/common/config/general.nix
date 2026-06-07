{
  kernel.config.general = {
    GENERIC_CPU = "n";
    MZEN4 = "n";
    X86_NATIVE_CPU = "y";

    DEFAULT_HOSTNAME = "v7w7r";
    DEFAULT_NET_SCH = "fq";
    DEFAULT_TCP_CONG = "bbr";

    PCIE_BUS_PERFORMANCE = "y";
    CC_OPTIMIZE_FOR_PERFORMANCE_O3 = "y";
    CPU_FREQ_DEFAULT_GOV_SCHEDUTIL = "y";
    CPU_FREQ_GOV_PERFORANCE = "y";
    CPU_FREQ_GOV_SCHEDUTIL = "y";
    CPU_FREQ_GOV_CONSERVATIVE = "y";
    CPU_FREQ_GOV_ONDEMAND = "y";
    CPU_FREQ_GOV_POWERSAVE = "y";
    CPU_FREQ_GOV_REFLEX = "y";
    BLK_DEV_NVME = "y";

    MMC = "y";
    DEFAULT_BBR = "y";
    DEFAULT_FQ = "y";
    HIBERNATION = "y";
    LTO_CLANG_THIN = "y";
    MQ_IOSCHED_ADIOS = "y";
    NET_SCH_FQ = "y";

    TCP_CONG_BBR = "y";
    TRANSPARENT_HUGEPAGE_MADVISE = "y";
    USB_ACM = "y";
    USB_SERIAL_FTDI_SIO = "y";
    USB_SERIAL_GENERIC = "y";
    USB_WDM = "y";

    BCACHE = "m";
    EXFAT_FS = "m";

    NET_SCH_FQ_CODEL = "m";
    KVM = "m";
    KVM_X86 = "m";
    TCP_CONG_CUBIC = "m";
    USB_SERIAL = "m";
    USB_SERIAL_CP210X = "m";
    VIRTIO = "m";

    ACCESSIBILITY = "n";
    CC_OPTIMIZE_FOR_PERFORMANCE = "n";
    CPUMASK_OFFSTACK = "n";
    DEFAULT_CUBIC = "n";
    DEFAULT_FQ_CODEL = "n";
    DEVPORT = "n";
    DRM_XE = "n";
    FUNCTION_ERROR_INJECTION = "n";
    FB_DEVICE = "n";
    GPIO_CDEV_V1 = "n";
    GPIOLIB_LEGACY = "n";
    HOTPLUG_CPU = "n";
    HOTPLUG_PCI_CPCI = "n";
    IO_STRICT_DEVMEM = "n";
    KALLSYMS_ALL = "n";
    KASAN = "n";
    KARMA_PARTITION = "n";
    KEXEC = "n";
    KEXEC_JUMP = "n";
    LOCALVERSION_AUTO = "n";
    LRU_GEN_STATS = "n";
    LTO_CLANG_FULL = "n";
    LTO_NONE = "n";
    MAXSMP = "n";
    MEDIA_CEC_RC = "n";
    MEDIA_CEC_SUPPORT = "n";
    MEDIA_SUPPORT = "n";
    NET_SCH_BPF = "n";
    NUMA = "n";
    QUOTA = "n";
    PROFILING = "n";
    PTP_1588_CLOCK = "n";
    REMOTEPROC = "n";
    RUNTIME_TESTING_MENU = "n";
    RUST = "n";
    RUSTC = "n";
    SCHED_CLUSTER = "n";
    SCHED_CLASS_EXT = "n";
    SCSI_DH = "n";
    SECURITY_SELINUX = "n";
    SECURITY_TOMOYO = "n";
    SERIAL_8250 = "n";
    SND_OSSEMUL = "n";
    STAGING = "n";
    STRICT_DEVMEM = "n";
    SYSFB_SIMPLEFB = "n";
    SYSTEM_BLACKLIST_KEYRING = "n";
    SYSTEM_REVOCATION_LIST = "n";
    SYSTEM_BLACKLIST_AUTH_UPDATE = "n";
    TRANSPARENT_HUGEPAGE_ALWAYS = "n";
    VIRTIO_VSOCKETS_COMMON = "n";
    WATCHDOG = "n";
  };
}

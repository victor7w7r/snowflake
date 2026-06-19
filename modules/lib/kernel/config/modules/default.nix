{
  kernel.config.modules.default = {
    BLK_DEV_NVME = "y";
    CC_OPTIMIZE_FOR_PERFORMANCE = "n";
    CC_OPTIMIZE_FOR_PERFORMANCE_O3 = "y";
    CPU_FREQ_GOV_PERFORANCE = "y";
    CPU_FREQ_GOV_REFLEX = "y";
    EXPERT = "y";
    GENERIC_CPU = "n";
    HZ_PERIODIC = "n";
    KVM = "y";
    LEGACY_VSYSCALL_NONE = "y";
    LTO_CLANG_FULL = "n";
    LTO_CLANG_THIN = "y";
    LTO_NONE = "n";
    NO_HZ = "y";
    NO_HZ_COMMON = "y";
    PCIE_BUS_PERFORMANCE = "y";
    PREEMPT_LAZY = "n";
    RANDSTRUCT_PERFORMANCE = "y";
    TRANSPARENT_HUGEPAGE_ALWAYS = "n";
    TRANSPARENT_HUGEPAGE_MADVISE = "y";
  };
}

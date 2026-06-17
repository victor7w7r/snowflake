{
  kernel.config.modules = {
    general = {
      BLK_DEV_NVME = "y";
      CC_OPTIMIZE_FOR_PERFORMANCE_O3 = "y";
      CPU_FREQ_GOV_PERFORANCE = "y";
      RANDSTRUCT_PERFORMANCE = "y";
      CPU_FREQ_GOV_REFLEX = "y";
      DEFAULT_BBR = "y";
      DEFAULT_HOSTNAME = "v7w7r";
      DEFAULT_NET_SCH = "fq";
      DEFAULT_TCP_CONG = "bbr";
      EXPERT = "y";
      GENERIC_CPU = "n";
      KVM = "y";
      LTO_CLANG_THIN = "y";
      MQ_IOSCHED_ADIOS = "y";
      NETFILTER_NETLINK = "y";
      NETFILTER_NETLINK_ACCT = "y";
      NETFILTER_NETLINK_LOG = "y";
      NETFILTER_NETLINK_OSF = "y";
      NETFILTER_NETLINK_QUEUE = "y";
      MZEN4 = "n";
      NET_SCH_FQ = "y";
      PCIE_BUS_PERFORMANCE = "y";
      TCP_CONG_BBR = "y";
      TRANSPARENT_HUGEPAGE_MADVISE = "y";
      X86_NATIVE_CPU = "y";
    };
  };
}

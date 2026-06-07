{
  kernel.config.blacklist = rec {
    all = label // virt // x86;

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

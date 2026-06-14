{
  kernel.lib.denial.general = rec {
    all = common // virt // x86;

    common = {
      ATA_GENERIC = "n";
      ATM = "n";
      FPGA = "n";
      FIREWIRE = "n";
      FUSION = "n";
      INFINIBAND = "n";
      MOST = "n";
      MOUSE_PS2 = "n";
      MULTIPLEXER = "n";
      NVME_TARGET = "n";
      NTB = "n";
      PARPORT= "n";
      PLIP = "n";
      PCCARD = "n";
      PCMCIA = "n";
      RPMSG = "n";
      STM = "n";
      SSB = "n";
      UIO = "n";
      W1 = "n";
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

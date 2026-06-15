{
  kernel.lib.denial.general = rec {
    all = common // virt // drivers // x86;

    common = {
      ATA_GENERIC = "n";
      ATM = "n";
      BCMA = "n";
      CXL_BUS = "n";
      EDAC = "n";
      FPGA = "n";
      MOST = "n";
      MOUSE_PS2 = "n";
      MULTIPLEXER = "n";
      NTB = "n";
      NVME_TARGET = "n";
      PARPORT = "n";
      PCCARD = "n";
      PCMCIA = "n";
      PLIP = "n";
      PPS = "n";
      RPMSG = "n";
      SSB = "n";
      STM = "n";
      UIO = "n";
      W1 = "n";
    };

    virt = {
      HYPERVISOR_GUEST = "n";
      VBOXGUEST = "n";
      KVM_XEN = "n";
      XEN = "n";
    };

    drivers = {
      AD525X_DPOT = "n";
      AD525X_DPOT_I2C = "n";
      AD525X_DPOT_SPI = "n";
      IBM_ASM = "n";
      PHANTOM = "n";
      TI_FPC202 = "n";
      TIFM_CORE = "n";
      TIFM_7XX1 = "n";
      ICS932S401 = "n";
      ENCLOSURE_SERVICES = "n";
      HP_ILO = "n";
      APDS9802ALS = "n";
      ISL29003 = "n";
      ISL29020 = "n";
      HMC6352 = "n";
      DS1682 = "n";
      LATTICE_ECP3_CONFIG = "n";
      DW_XDATA_PCIE = "n";
      PCI_ENDPOINT_TEST = "n";
      XILINX_SDFEC = "n";
      MISC_RTSX = "n";
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

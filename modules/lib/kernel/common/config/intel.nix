{
  kernel.lib.config.intel = {
    CPU_SUP_INTEL = "y";
    DRM_I915 = "y";
    X86_INTEL_PSTATE = "y";

    NET_VENDOR_INTEL = "y";
    BT_INTEL = "m";
    DRM_I915_GVT_KVMGT = "m";
    KVM_INTEL = "m";
    MFD_INTEL_LPSS = "m";
    MFD_INTEL_LPSS_PCI = "m";

    AMD_3D_VCACHE = "n";
    AMD_HFI = "n";
    AMD_IOMMU = "n";
    AMD_MEM_ENCRYPT = "n";
    AMD_NB = "n";
    AMD_NODE = "n";
    AMD_SECURE_AVIC = "n";
    AMD_WBRF = "n";
    CPU_SUP_AMD = "n";
    CPU_SUP_HYGON = "n";
    KVM_AMD = "n";
    NET_VENDOR_AMD = "n";
    PERF_EVENTS_AMD_BRS = "n";
    PINCTRL_AMD = "n";
    SOUNDWIRE_AMD = "n";
    USB_PCI_AMD = "n";
    X86_AMD_PLATFORM_DEVICE = "n";
    X86_AMD_PSTATE = "n";
    X86_MCE_AMD = "n";
  };
}

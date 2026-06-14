{
  kernel.lib.config = rec {

    all-vendor = net-vendor-enable;

    net-vendor-enable = {
      NET_VENDOR_AQUANTIA = "y";
      NET_VENDOR_BROADCOM = "y";
      NET_VENDOR_REALTEK = "y";
      NET_VENDOR_MICROSOFT = "y";
      WLAN_VENDOR_BROADCOM = "y";
      WLAN_VENDOR_INTEL = "y";
      WLAN_VENDOR_MEDIATEK = "y";
      WLAN_VENDOR_REALTEK = "y";
      WLAN_VENDOR_RALINK = "y";
    };
  };
}

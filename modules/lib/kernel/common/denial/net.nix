{
  kernel.lib.denial.net = rec {
    all = hardware // tcp;

    hardware = {
      "6LOWPAN" = "n";
      B43 = "n";
      B43LEGACY = "n";
      B44 = "n";
      B53 = "n";
      BRCMUTIL = "n";
      BRCMSMAC = "n";
      BRCMFMAC = "n";
      CAN = "n";
      IEEE802154 = "n";
      MAC802154 = "n";
      MISDN = "n";
      PPP = "n";
      RTW88 = "n";
      RTW89 = "n";
      WWAN = "n";
    };

    tcp = {
      TCP_CONG_WESTWOOD = "n";
      TCP_CONG_HTCP = "n";
      TCP_CONG_HSTCP = "n";
      TCP_CONG_HYBLA = "n";
      TCP_CONG_VEGAS = "n";
      TCP_CONG_NV = "n";
      TCP_CONG_SCALABLE = "n";
      TCP_CONG_LP = "n";
      TCP_CONG_VENO = "n";
      TCP_CONG_YEAH = "n";
      TCP_CONG_ILLINOIS = "n";
      TCP_CONG_DCTCP = "n";
      TCP_CONG_CDG = "n";
    };
  };
}

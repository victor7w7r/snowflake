{
  kernel.config.denial.gpio = rec {

    all = clk // extcon // general // controllers;

    clk = {
      LMK04832 = "n";
      COMMON_CLK_MAX9485 = "n";
      COMMON_CLK_SI5341 = "n";
      COMMON_CLK_SI5351 = "n";
      COMMON_CLK_SI544 = "n";
      COMMON_CLK_CDCE706 = "n";
      COMMON_CLK_TPS68470 = "n";
      COMMON_CLK_CS2000_CP = "n";
      COMMON_CLK_PWM = "n";
      XILINX_VCU = "n";
    };

    extcon = {
      EXTCON_ADC_JACK = "n";
      EXTCON_FSA9480 = "n";
      EXTCON_INTEL_INT3496 = "n";
      EXTCON_INTEL_CHT_WC = "n";
      EXTCON_INTEL_MRFLD = "n";
      EXTCON_LC824206XA = "n";
      EXTCON_MAX3355 = "n";
      EXTCON_MAX14526 = "n";
      EXTCON_PTN5150 = "n";
      EXTCON_RT8973A = "n";
      EXTCON_SM5502 = "n";
      EXTCON_USBC_TUSB320 = "n";
    };

    controllers = {
      NSM = "n";
      C2PORT = "n";
      CB710_CORE = "n";
      ALTERA_STAPL = "n";
      EEPROM_AT24 = "n";
      EEPROM_MAX6875 = "n";
      EEPROM_93CX6 = "n";
      EEPROM_IDT_89HPESX = "n";
      EEPROM_EE1004 = "n";
      EEPROM_M24LR = "n";
    };

    general = {
      UIO = "n";
      GPIO_74X164 = "n";
      GPIO_AGGREGATOR = "n";
      GPIO_ALTERA = "n";
      GPIO_AMD8111 = "n";
      GPIO_AMDPT = "n";
      GPIO_AMD_FCH = "n";
      GPIO_ARIZONA = "n";
      GPIO_BD9571MWV = "n";
      GPIO_CGBC = "n";
      GPIO_DLN2 = "n";
      GPIO_DS4520 = "n";
      GPIO_DWAPB = "n";
      GPIO_ELKHARTLAKE = "n";
      GPIO_EXAR = "n";
      GPIO_F7188X = "n";
      GPIO_FXL6408 = "n";
      GPIO_GENERIC = "n";
      GPIO_GENERIC_PLATFORM = "n";
      GPIO_GRANITERAPIDS = "n";
      GPIO_ICH = "n";
      GPIO_IDIO_16 = "n";
      GPIO_IT87 = "n";
      GPIO_JANZ_TTL = "n";
      GPIO_KEMPLD = "n";
      GPIO_LATCH = "n";
      GPIO_LJCA = "n";
      GPIO_LP3943 = "n";
      GPIO_LP873X = "n";
      GPIO_MADERA = "n";
      GPIO_MAX3191X = "n";
      GPIO_MAX7300 = "n";
      GPIO_MAX7301 = "n";
      GPIO_MAX730X = "n";
      GPIO_MAX732X = "n";
      GPIO_MAX7360 = "n";
      GPIO_MB86S7X = "n";
      GPIO_MC33880 = "n";
      GPIO_MENZ127 = "n";
      GPIO_ML_IOH = "n";
      GPIO_MOCKUP = "n";
      GPIO_MPSSE = "n";
      GPIO_NCT6694 = "n";
      GPIO_PALMAS = "n";
      GPIO_PCA953X = "n";
      GPIO_PCA953X_IRQ = "n";
      GPIO_PCA9570 = "n";
      GPIO_PCF857X = "n";
      GPIO_PCIE_IDIO_24 = "n";
      GPIO_PCI_IDIO_16 = "n";
      GPIO_PISOSR = "n";
      GPIO_RC5T583 = "n";
      GPIO_RDC321X = "n";
      GPIO_REGMAP = "n";
      GPIO_SCH = "n";
      GPIO_SCH311X = "n";
      GPIO_SIM = "n";
      GPIO_SIOX = "n";
      GPIO_SWNODE_UNDEFINED = "n";
      GPIO_TANGIER = "n";
      GPIO_TPIC2810 = "n";
      GPIO_TPS65086 = "n";
      GPIO_TPS6586X = "n";
      GPIO_TPS65910 = "n";
      GPIO_TPS65912 = "n";
      GPIO_TPS68470 = "n";
      GPIO_TQMX86 = "n";
      GPIO_USBIO = "n";
      GPIO_VIPERBOARD = "n";
      GPIO_VIRTIO = "n";
      GPIO_VX855 = "n";
      GPIO_WHISKEY_COVE = "n";
      GPIO_WINBOND = "n";
      GPIO_WM8994 = "n";
      GPIO_WS16C48 = "n";
      GPIO_XILINX = "n";
      GPIO_XRA1403 = "n";

    };
  };
}

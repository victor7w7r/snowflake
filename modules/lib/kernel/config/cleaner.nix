{
  kernel.config.cleaner.cmd = ''
    sed -i '/^[[:space:]]*#/d; /^[[:space:]]*$/d' .config
    sed -i '/^CONFIG_BATTERY_/d' .config
    sed -i '/^CONFIG_CHARGER_/d' .config
    sed -i '/^CONFIG_COMMON_CLK_/d' .config
    sed -i '/^CONFIG_DELL_/d' .config
    sed -i '/^CONFIG_EEPROM_/d' .config
    sed -i '/^CONFIG_GAMEPORT_/d' .config
    sed -i '/^CONFIG_JOYSTICK_/d' .config
    sed -i '/^CONFIG_MOUSE_/d' .config
    sed -i '/^CONFIG_NLS_ISO8859_/d' .config
    sed -i '/^CONFIG_NLS_MAC_/d' .config
    sed -i '/^CONFIG_PATA_/d' .config
    sed -i '/^CONFIG_RMI4_/d' .config
    sed -i '/^CONFIG_SERIO_/d' .config
    sed -i '/^CONFIG_TOUCHSCREEN_/d' .config
    sed -i '/^CONFIG_USB_STORAGE_/d' .config
    sed -i '/CONFIG_BACKLIGHT_/ { /CONFIG_BACKLIGHT_CLASS_DEVICE/!d }' .config
    sed -i '/CONFIG_KEYBOARD_/ { /CONFIG_KEYBOARD_ATKBD/!d }' .config
    sed -i '/CONFIG_NLS_ASCII=y/a CONFIG_NLS_ISO8859_1=y' .config
    sed -i '/CONFIG_NLS_CODEPAGE_/ { /CONFIG_NLS_CODEPAGE_437/!d }' .config
    sed -i '/CONFIG_RTC_DRV_/ { /CONFIG_RTC_DRV_CMOS/!d }' .config
    sed -i -E '/CONFIG_EXTCON_/ { /CONFIG_EXTCON_GPIO|CONFIG_EXTCON_USB_GPIO/!d }' .config
    sed -i -E '/CONFIG_HID_/ { /CONFIG_HID_SUPPORT|CONFIG_HID_BATTERY_STRENGTH|CONFIG_HID_GENERIC|CONFIG_HID_HAPTIC|CONFIG_HID_ASUS|CONFIG_HID_WACOM|CONFIG_HID_PID/!d }' .config
    sed -i -E '/CONFIG_LEDS_/ { /CONFIG_LEDS_CLASS|CONFIG_LEDS_TRIGGERS|CONFIG_LEDS_TRIGGER_DISK|CONFIG_LEDS_TRIGGER_CPU/!d }' .config
    sed -i -E '/CONFIG_NET_SCH_/ { /CONFIG_NET_SCH_FQ_CODEL|CONFIG_NET_SCH_FQ|CONFIG_NET_SCH_INGRESS|CONFIG_NET_SCH_DEFAULT|CONFIG_NET_SCH_HTB|CONFIG_NET_SCH_FIFO/!d }' .config
    sed -i -E '/CONFIG_REGULATOR_/ { /CONFIG_REGULATOR_FIXED_VOLTAGE|CONFIG_REGULATOR_NETLINK_EVENTS/!d }' .config
    sed -i -E '/CONFIG_TCP_CONG_/ { /CONFIG_TCP_CONG_ADVANCED|CONFIG_TCP_CONG_CUBIC|CONFIG_TCP_CONG_BBR/!d }' .config
    sed -i -E '/CONFIG_TYPEC_/ { /CONFIG_TYPEC_UCSI|CONFIG_TYPEC_DP_ALTMODE|CONFIG_TYPEC_TBT_ALTMODE/!d }' .config
    sed -i -E '/CONFIG_USB_SERIAL_/ { /CONFIG_USB_SERIAL_GENERIC|CONFIG_USB_SERIAL_CP210X|CONFIG_USB_SERIAL_CYPRESS_M8|CONFIG_USB_SERIAL_EMPEG|CONFIG_USB_SERIAL_FTDI_SIO/!d }' .config
  '';
}

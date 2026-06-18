{
  kernel.config.cleaner.cmd = ''
    sed -i '/^[[:space:]]*#/d; /^[[:space:]]*$/d' .config
    sed -i '/^CONFIG_BATTERY_/d' .config
    sed -i '/^CONFIG_CHARGER_/d' .config
    sed -i '/^CONFIG_DELL_/d' .config
    sed -i '/^CONFIG_JOYSTICK_/d' .config
    sed -i '/^CONFIG_MOUSE_/d' .config
    sed -i '/^CONFIG_NET_ACT_/d' .config
    sed -i '/^CONFIG_BRIDGE_EBT_/d' .config
    sed -i '/^CONFIG_TOUCHSCREEN_/d' .config
    sed -i '/CONFIG_KEYBOARD_/ { /CONFIG_KEYBOARD_ATKBD/!d }' .config
    sed -i '/NET_VENDOR_/ { /NET_VENDOR_REALTEK/!d }' .config
    sed -i '/WLAN_VENDOR_/ { /WLAN_VENDOR_MEDIATEK/!d }' .config
  '';
}

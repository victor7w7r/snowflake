{
  kernel.config.cleaner.cmd = ''
    sed -i '/^[[:space:]]*#/d; /^[[:space:]]*$/d' .config
    sed -i '/^CONFIG_BATTERY_/d' .config
    sed -i '/^CONFIG_CHARGER_/d' .config
    sed -i '/^CONFIG_DELL_/d' .config
    sed -i '/^CONFIG_JOYSTICK_/d' .config
    sed -i '/^CONFIG_MOUSE_/d' .config
    sed -i '/^CONFIG_TOUCHSCREEN_/d' .config
    sed -i '/CONFIG_KEYBOARD_/ { /CONFIG_KEYBOARD_ATKBD/!d }' .config
  '';
}

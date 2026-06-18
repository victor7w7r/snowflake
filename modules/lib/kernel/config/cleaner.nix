{
  kernel.config.cleaner = ''
    sed -i '/^[[:space:]]*#/d; /^[[:space:]]*$/d' .config
    sed -i '/CONFIG_KEYBOARD_/ { /CONFIG_KEYBOARD_ATKBD/!d }' .config
  '';
}

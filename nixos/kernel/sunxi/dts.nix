{ armbian }:
''
  chmod -R +w arch/arm64/boot/dts/allwinner/Makefile
  rm -rf arch/arm64/boot/dts/allwinner/Makefile
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero2w.dtb" > "arch/arm64/boot/dts/allwinner/Makefile"
  echo "subdir-y       := \$(dts-dirs) overlay" >> "arch/arm64/boot/dts/allwinner/Makefile"
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/overlay_64 arch/arm64/boot/dts/allwinner/overlay
  rm -rf arch/arm64/boot/dts/allwinner/overlay/Makefile

  cat << 'EOF' > arch/arm64/boot/dts/allwinner/overlay/Makefile
  dtb-\$(CONFIG_ARCH_SUNXI) += \\
      sun50i-h616-gpu.dtbo \\
      sun50i-h616-i2c0-pi.dtbo \\
      sun50i-h616-i2c1-pi.dtbo \\
      sun50i-h616-i2c2-pi.dtbo \\
      sun50i-h616-i2c3-ph.dtbo \\
      sun50i-h616-keys.dtbo \\
      sun50i-h616-pwm1-ph3.dtbo \\
      sun50i-h616-uart5.dtbo \\
      sun50i-h616-spi-spidev.dtbo \\
      sun50i-h616-ir.dtbo \\
      sun50i-h616-light.dtbo

  scr-\$(CONFIG_ARCH_SUNXI) += \\
      sun50i-h616-fixup.scr

  targets += \$(dtb-y) \$(scr-y) \$(dtbotxt-y)

  always        := \$(dtb-y) \$(scr-y) \$(dtbotxt-y)
  clean-files   := *.dtbo *.scr
  EOF
''

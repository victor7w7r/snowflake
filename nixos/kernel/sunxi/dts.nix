{ armbian }:
''
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/overlay_64 arch/arm64/boot/dts/allwinner/overlay
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h616-bigtreetech-cb1-emmc.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h616-bigtreetech-cb1-sd.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h618-bananapi-m4-berry.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h618-bananapi-m4-zero.dts arch/arm64/boot/dts/allwinner/

  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-emmc.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-sd.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h618-bananapi-m4-berry.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h618-bananapi-m4-zero.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "subdir-y       := \$(dts-dirs) overlay" >> "arch/arm64/boot/dts/allwinner/Makefile"
''

{ armbian }:
''
  chmod -R +w arch/arm64/boot/dts/allwinner/Makefile
  rm -rf arch/arm64/boot/dts/allwinner/Makefile
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero2w.dtb" > "arch/arm64/boot/dts/allwinner/Makefile"
  echo "subdir-y       := \$(dts-dirs) overlay" >> "arch/arm64/boot/dts/allwinner/Makefile"

  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/overlay_64 arch/arm64/boot/dts/allwinner/overlay
  chmod -R +w arch/arm64/boot/dts/allwinner/overlay
  rm -rf arch/arm64/boot/dts/allwinner/overlay/Makefile
  cp -r ${./Makefile} arch/arm64/boot/dts/allwinner/overlay/Makefile
''

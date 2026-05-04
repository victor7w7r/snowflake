{ armbian }:
''
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/overlay_64 arch/arm64/boot/dts/allwinner/overlay
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-a64-olinuxino-1G.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-a64-olinuxino-1Ge16GW.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-a64-olinuxino-1Ge4GW.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-a64-olinuxino-1Gs16M.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-a64-olinuxino-2Ge8G.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-a64-pinephone-1.2b.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h313-x96q-lpddr3.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h5-nanopi-k1-plus.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h5-nanopi-m1-plus2.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h5-nanopi-neo-core2.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h5-nanopi-neo2-v1.1.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h6-inovato-quadra.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h6-orangepi-3-lts.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h616-bigtreetech-cb1-emmc.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h616-bigtreetech-cb1-sd.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h618-bananapi-m4-berry.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h618-bananapi-m4-zero.dts arch/arm64/boot/dts/allwinner/
  cp -r ${armbian}/patch/kernel/archive/sunxi-6.18/dt_64/sun50i-h618-kickpi-k2b.dts arch/arm64/boot/dts/allwinner/

  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino-1G.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino-1Ge16GW.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino-1Ge4GW.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino-1Gs16M.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino-2Ge8G.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.2b.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h313-x96q-lpddr3.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-k1-plus.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-m1-plus2.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-core2.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2-v1.1.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h6-inovato-quadra.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3-lts.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-emmc.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-sd.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h618-bananapi-m4-berry.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h618-bananapi-m4-zero.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "dtb-\$(CONFIG_ARCH_SUNXI) += sun50i-h618-kickpi-k2b.dtb" >> "arch/arm64/boot/dts/allwinner/Makefile"
  echo "subdir-y       := \$(dts-dirs) overlay" >> "arch/arm64/boot/dts/allwinner/Makefile"
''

{
  pkgs,
  device ? "fajita",
  ...
}:
let
  uboot = pkgs.buildUBoot {
    #bootcmd=scsi scan; load scsi 0:11 ${kernel_addr_r} /EFI/BOOT/BOOTAA64.EFI; bootefi ${kernel_addr_r}
    src = fetchGit {
      url = "https://gitlab.postmarketos.org/tauchgang/u-boot.git";
      rev = "540db1c376fe304c423964809428ba0a0d1db378";
    };
    version = "master";
    extraMakeFlags = [ "DEVICE_TREE=qcom/sdm845-oneplus-fajita" ];
    defconfig = "qcom_defconfig qcom-phone.config tauchgang.config";
    extraMeta.platforms = [ "aarch64-linux" ];
    extraConfig = ''
      CONFIG_CMD_HASH=y
      CONFIG_CMD_BLKMAP=y
      CONFIG_BLKMAP=y
      CONFIG_CMD_UFETCH=y
      CONFIG_CMD_SELECT_FONT=y
      CONFIG_VIDEO_FONT_16X32=y
      CONFIG_BOOTDELAY=5
    '';
    nativeBuildInputs = with pkgs; [
      xxd
      bison
      flex
      openssl
      gnutls
      android-tools
    ];

    filesToInstall = [
      "u-boot*"
      "dts/upstream/src/arm64/qcom/sdm845-oneplus-${device}.dtb"
    ];
  };
in
pkgs.stdenvNoCC.mkDerivation {
  name = "sdm845-oneplus-bootimg";
  dontBuild = true;
  dontFixup = true;
  src = uboot;
  nativeBuildInputs = with pkgs; [
    android-tools
    mkbootimg
    gzip
  ];
  installPhase = ''
    mkdir -p $out
    cp ${uboot}/u-boot-nodtb.bin ./u-boot-nodtb.bin
    cp ${uboot}/${"sdm845-oneplus-${device}.dtb"} ./${"sdm845-oneplus-${device}.dtb"}
    gzip ./u-boot-nodtb.bin
    cat ./u-boot-nodtb.bin.gz ${uboot}/${"sdm845-oneplus-${device}.dtb"} > ubootwithdtb
    mkbootimg \
      --kernel ./ubootwithdtb \
      --base 0x0 \
      --ramdisk /dev/null \
      --kernel_offset 0x8000 \
      --pagesize 4096 \
      -o "boot.img"

    cp sdm845-oneplus-${device}.dtb $out/
    cp boot.img $out/
  '';
}

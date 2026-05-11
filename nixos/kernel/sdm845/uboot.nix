{
  pkgs,
  device ? "fajita",
  ...
}:
let
  uboot = pkgs.buildUBoot {
    src = fetchGit {
      url = "https://git.codelinaro.org/clo/qcomlt/u-boot.git";
      rev = "6fc40f2499b1a517487933d7d81a482f6dce7751";
    };
    version = "master";
    extraMakeFlags = [ "DEVICE_TREE=qcom/sdm845-oneplus-${device}" ];
    defconfig = "qcom_defconfig phone.config";
    extraMeta.platforms = [ "aarch64-linux" ];
    prePatch = ''
      cp ${./qcom-phone.env} board/qualcomm/qcom-phone.env
    '';
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

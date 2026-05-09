{
  pkgs,
  device ? "fajita",
  ...
}:
let
  uboot = pkgs.buildUBoot {
    src = fetchGit {
      url = "https://gitlab.postmarketos.org/tauchgang/u-boot.git";
      rev = "3b00343d6a936499cbe8db9e022c1faa04708125";
    };
    version = "master";
    extraMakeFlags = [ "DEVICE_TREE=qcom/sdm845-oneplus-${device}" ];
    defconfig = "qcom_defconfig qcom-phone.config tauchgang.config";
    extraMeta.platforms = [ "aarch64-linux" ];
    postPatch = ''
      sed -i 's/bootcmd=.*/bootcmd=scsi scan; load scsi 0:11 ''${kernel_addr_r} \/EFI\/BOOT\/BOOTAA64.EFI; bootefi ''${kernel_addr_r}/' board/qualcomm/qcom-phone.env
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
      "u-boot-nodtb.bin"
      "u-boot.dtb"
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

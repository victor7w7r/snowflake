{
  lib,
  pkgs,
  kernelData,
  device ? "fajita",
  ...
}:
let
  majorMinor = lib.versions.majorMinor kernelData.sdm845.version;
  #fetch = (pkgs.callPackage ../fetch.nix { inherit kernelData majorMinor; });
  uboot = pkgs.buildUBoot {
    src = fetchGit {
      url = "https://gitlab.postmarketos.org/tauchgang/u-boot.git";
      rev = "540db1c376fe304c423964809428ba0a0d1db378";
    };
    version = "master";
    extraMakeFlags = [ "DEVICE_TREE=qcom/sdm845-oneplus-${device}" ];
    defconfig = "qcom_defconfig qcom-phone.config tauchgang.config";
    extraMeta.platforms = [ "aarch64-linux" ];
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
    /*
      prePatch = ''
      #cat configs/qcom_defconfig board/qualcomm/qcom-phone.config > f
      #mv f configs/qcom_defconfig

      #rm dts/upstream/src/arm64/qcom/sdm845-oneplus-enchilada.dts
      #rm dts/upstream/src/arm64/qcom/sdm845-oneplus-fajita.dts

      cp ${./qcom-phone.env} board/qualcomm/qcom-phone.env
      cp ${./qcom-phone.config} board/qualcomm/qcom-phone.config

      #cp -r ${./common.dtsi} dts/upstream/src/arm64/qcom/sdm845-oneplus-common.dtsi
      #cp -r ${./${device}.dts} dts/upstream/src/arm64/qcom/sdm845-oneplus-${device}.dts
      #cp -r ${./common.dtsi} dts/upstream/src/arm64/qcom/sdm845-oneplus-common.dtsi

      #cp -r ${fetch.sdm845}/include/dt-bindings/input/qcom,spmi-haptics.h dts/upstream/include/dt-bindings/input
      #cp -r ${fetch.sdm845}/include/dt-bindings/sound/qcom,q6voice.h dts/upstream/include/dt-bindings/sound
      #cp -r ${fetch.sdm845}/include/uapi/linux/input-event-codes.h dts/upstream/include/dt-bindings/input/linux-event-codes.h
      #chmod -R +w dts/upstream/src/arm64/
      '';
    */
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

    gzip -c u-boot-nodtb.bin > u-boot.bin.gz

    mkbootimg \
      --kernel u-boot.bin.gz \
      --dtb ./${"sdm845-oneplus-${device}.dtb"} \
      --base 0x0 \
      --kernel_offset 0x8000 \
      --ramdisk_offset 0x01000000 \
      --tags_offset 0x100 \
      --pagesize 4096 \
      --header_version 2 \
      -o "boot.img"

    cp sdm845-oneplus-${device}.dtb $out/
    cp boot.img $out/
  '';
}

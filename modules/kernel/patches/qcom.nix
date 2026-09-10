{ inputs, self, ... }:
{
  kernel.patches = {
    qcom =
      { }:
      "${self}/modules/kernel/patches/sdm845"
      |> builtins.readDir
      |> builtins.attrNames
      |> builtins.filter (
        filename:
        !builtins.elem filename [
          "0004-Xiaomi-Poco-F1-ebbg-display-variant-fixes.patch"
          "0008-SDM845-DOWNSTREAM-EDITME-cover-title-for-qcom-spmi-s.patch"
          "0010-ntfs-fix-resource-leak-in-ntfs_new_attr_flags.patch"
          "0011-arm64-dts-qcom-pmi8998-Introduce-SPMI-haptics.patch"
          "0012-arm64-dts-qcom-sdm845-oneplus-Add-haptics-support.patch"
          "0016-Qualcomm-3rd-gen-fuel-gauge-support.patch"
          "0019-arm64-dts-qcom-pmi8998-Add-fuel-gauge.patch"
          "0024-EDITME-cover-title-for-ath10k-a-msdu.patch"
          "0026-Mainlining-effort-for-TAS255x.patch"
          "0028-arm64-dts-qcom-sdm845-xiaomi-beryllium-Enable-gpi_dm.patch"
          "0029-arm64-dts-qcom-sdm845-xiaomi-beryllium-common-add-su.patch"
          "0030-HACK-series-for-working-qdsp6.patch"
          "0058-hack-arm64-dts-qcom-sdm845-Add-q6voice-APR-service-d.patch"
          "0059-hack-arm64-dts-xiaomi-beryllium-common-Add-nodes-for.patch"
          "0060-hack-arm64-dts-qcom-sdm845-oneplus-common-add-nodes-.patch"
          "0061-hack-arm64-dts-qcom-sdm845-shift-axolotl-add-nodes-f.patch"
          "0062-END-HACK-series-for-working-qdsp6.patch"
          "0063-stalled-arm64-dts-qcom-sdm845-xiaomi-beryllium-add-s.patch"
          "0065-Enable-DW9714V-camera-focus-coils-on-SHIFT-6MQ.patch"
          "0069-EDITME-cover-title-for-shift6-camera.patch"
          "0070-arm64-dts-qcom-sdm845-shift-axolotl-Introduce-main-c.patch"
          "0076-EDITME-cover-title-for-axolotl-misc.patch"
          "0077-arm64-dts-qcom-sdm845-shift-axolotl-Enable-sound-sub.patch"
          "0078-stalled-arm64-qcom-sdm845-shift-axolotl-Improve-audi.patch"
          "0082-arm64-dts-freescale-Convert-to-new-media-orientation.patch"
          "0083-arm64-dts-qcom-Convert-to-new-media-orientation-defi.patch"
          "0084-arm64-dts-renesas-Convert-to-new-media-orientation-d.patch"
          "0085-arm64-dts-rockchip-Convert-to-new-media-orientation-.patch"
          "0086-Add-initial-dual-front-camera-and-rear-flash-support.patch"
          "0087-arm64-dts-qcom-sdm845-google-Add-dual-front-IMX355-c.patch"
          "0088-arm64-dts-qcom-sdm845-google-Enable-PMI8998-camera-f.patch"
          "0089-EDITME-downstream-cameras.patch"
          "0093-stalled-media-i2c-Add-imx519-image-sensor-driver.patch"
          "0094-arm64-dts-qcom-sdm845-xiaomi-beryllium-Add-support-f.patch"
          "0095-arm64-dts-qcom-sdm845-google-Wire-the-back-camera.patch"
          "0096-arm64-dts-qcom-sdm845-oneplus-Camera-bringup.patch"
          "0098-stalled-arm64-dts-qcom-sdm845-xiaomi-beryllium-Add-q.patch"
          "0100-power-supply-pmi8998-charger-improvements-and-smb5-s.patch"
          "0106-xiaomi-perseus-support.patch"
          "0107-arm64-dts-qcom-Introduce-support-for-Xiaomi-Mi-Mix-3.patch"
          "0108-EDITME-cover-title-for-rpmsg-qcom-glink.patch"
          "0110-Add-framebuffer-on-Xiaomi-Poco-F1-and-disable-the-MD.patch"
          "0111-arm64-dts-qcom-sdm845-xiaomi-beryllium-tianma-Disabl.patch"
          "0112-arm64-dts-qcom-sdm845-google-Enable-fuel-gauge.patch"
          "0113-arm64-dts-qcom-sdm845-oneplus-add-rear-camera-actuat.patch"
          "0114-Input-support-for-STM-FTS5.patch"
          "0118-arm64-dts-qcom-sdm845-google-Add-STM-FTS-touchscreen.patch"
          "0119-drm-panel-visionox-rm69299-Split-DSI-commands-out-in.patch"
          "0122-Add-DRM-driver-for-LG-LH609QH1-Panel-with-SiliconWor.patch"
          "0126-EDITME-cover-title-for-judyln-touchscreen.patch"
          "0132-arm64-dts-qcom-sdm845-lg-fix-sdcard-pinctrl-nodes.patch"
          "0133-EDITME-cover-title-for-lg-judyln-leftover.patch"
          "0134-arm64-dts-qcom-sdm845-lg-common-Enable-NFC.patch"
          "0135-EDITME-cover-title-for-synaptics-rmi4-fnsplit.patch"
          "0137-Input-synaptics-rmi4-add-quirks-for-third-party-touc.patch"
          "0144-EDITME-cover-title-for-oneplus-ts-quirk.patch"
          "0145-arm64-dts-qcom-sdm845-oneplus-Move-touchscreen-y-axi.patch"
          "0146-arm64-dts-qcom-sdm845-oneplus-Specify-touchscreen-in.patch"
          "0147-EDITME-cover-title-for-tfa98xx.patch"
          "0148-arm64-dts-qcom-sdm845-oneplus-fajita-Enable-speaker-.patch"
          "0151-media-camss-Add-support-for-C-PHY-configuration-on-Q.patch"
          "0161-Pixel-3-XL-display-panel-support.patch"
          "0167-arm64-dts-qcom-sdm845-samsung-starqltechn-Update-pan.patch"
          "0168-arm64-dts-qcom-sdm845-google-crosshatch-Add-display-.patch"
          "0169-EDITME-cover-title-for-dipper.patch"
          "0170-dt-bindings-arm-qcom-Add-Xiaomi-Mi-8.patch"
          "0171-arm64-dts-qcom-add-Xiaomi-Mi-8-dipper.patch"
          "0172-EDITME-cover-title-for-no_init_park.patch"
          "0174-EDITME-cover-title-for-csiphy-sdm845-limits.patch"
          "0176-EDITME-cover-title-for-wcd-dma.patch"
          "0178-Speakers-for-Pixel-3-3-XL.patch"
          "0184-arm64-dts-qcom-sdm845-google-Add-basic-audio-support.patch"
          "0186-arm64-dts-qcom-sdm845-google-Add-WCD9340-codec-and-m.patch"
          "0187-Pixel-3-display-fixes.patch"
          "0190-Add-modemsmem-for-Google-phones.patch"
          "0192-soc-qcom-Add-modemsmem-for-Google-phones.patch"
          "0193-arm64-dts-qcom-sdm845-google-Add-modemsmem.patch"
          "0194-EDITME-cover-title-for-ea8074.patch"
          "0197-latest-hot-fixes-separator.patch"
          "0200-arm64-dts-qcom-sdm845-shift-axolotl-add-wcd934x-MBHC.patch"
          "0206-arm64-dts-qcom-sdm845-google-Add-rear-camera-VCM.patch"
          "0209-arm64-dts-qcom-sdm845-google-Enable-VoiceMMode1-for-.patch"
          "0210-arm64-dts-qcom-sdm845-xiaomi-dipper-Enable-the-displ.patch"
          "0211-arm64-dts-qcom-sdm845-xiaomi-dipper-Add-touchscreen.patch"
        ]
      )
      |>
        map (filename: "${self}/modules/kernel/patches/sdm845/${filename}")
        ++ [
          "${self}/modules/kernel/patches/files/fix-qcom-smbx-init.patch"
        ];

    qcom-defconfig =
      pkgs:
      (pkgs.runCommand "qcom-defconfig" { } ''
        cp ${inputs.linux-sdm845}/arch/arm64/configs/defconfig defconfig
        cp ${inputs.linux-sdm845}/arch/arm64/configs/sdm845.config sdm845.config
        cat defconfig sdm845.config | sed '/CONFIG_LOCALVERSION/d' > $out
      '');
  };
}

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
          "0011-arm64-dts-qcom-pmi8998-Introduce-SPMI-haptics.patch"
          "0012-arm64-dts-qcom-sdm845-oneplus-Add-haptics-support.patch"
          "0016-Qualcomm-3rd-gen-fuel-gauge-support.patch"
          "0019-arm64-dts-qcom-pmi8998-Add-fuel-gauge.patch"
          "0024-EDITME-cover-title-for-ath10k-a-msdu.patch"
          "0025-wifi-ath10k-make-in-order-rx-amsdu-buffers-persisten.patch" # !
          "0026-Mainlining-effort-for-TAS255x.patch"
          "0028-arm64-dts-qcom-sdm845-xiaomi-beryllium-Enable-gpi_dm.patch"
          "0029-arm64-dts-qcom-sdm845-xiaomi-beryllium-common-add-su.patch"
          "0030-HACK-series-for-working-qdsp6.patch"
          "0043-hack-ASoC-dt-bindings-qcom-q6dsp-add-internal-mi2s-s.patch" # !
          "0044-hack-ASoC-qdsp6-q6dsp-lpass-ports-add-internal-mi2s-.patch" # !
          "0045-hack-ASoC-qdsp6-q6afe-add-internal-mi2s-support.patch" # !
          "0046-hack-ASoC-qdsp6-q6afe-dai-add-internal-mi2s-support.patch" # !
          "0047-hack-ASoC-qdsp6-q6routing-add-internal-mi2s-support.patch" # !
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
          "0086-Add-initial-dual-front-camera-and-rear-flash-support.patch"
          "0089-EDITME-downstream-cameras.patch"
          "0100-power-supply-pmi8998-charger-improvements-and-smb5-s.patch"
          "0106-xiaomi-perseus-support.patch"
          "0108-EDITME-cover-title-for-rpmsg-qcom-glink.patch"
          "0110-Add-framebuffer-on-Xiaomi-Poco-F1-and-disable-the-MD.patch"
          "0114-Input-support-for-STM-FTS5.patch"
          "0119-drm-panel-visionox-rm69299-Split-DSI-commands-out-in.patch"
          "0122-Add-DRM-driver-for-LG-LH609QH1-Panel-with-SiliconWor.patch"
          "0126-EDITME-cover-title-for-judyln-touchscreen.patch"
          "0133-EDITME-cover-title-for-lg-judyln-leftover.patch"
          "0135-EDITME-cover-title-for-synaptics-rmi4-fnsplit.patch"
          "0137-Input-synaptics-rmi4-add-quirks-for-third-party-touc.patch"
          "0144-EDITME-cover-title-for-oneplus-ts-quirk.patch"
          "0147-EDITME-cover-title-for-tfa98xx.patch"
          "0151-media-camss-Add-support-for-C-PHY-configuration-on-Q.patch"
          "0161-Pixel-3-XL-display-panel-support.patch"
          "0169-EDITME-cover-title-for-dipper.patch"
          "0172-EDITME-cover-title-for-no_init_park.patch"
          "0174-EDITME-cover-title-for-csiphy-sdm845-limits.patch"
          "0176-EDITME-cover-title-for-wcd-dma.patch"
          "0178-Speakers-for-Pixel-3-3-XL.patch"
          "0187-Pixel-3-display-fixes.patch"
          "0190-Add-modemsmem-for-Google-phones.patch"
          "0194-EDITME-cover-title-for-ea8074.patch"
        ]
      )
      |> map (filename: "${self}/modules/kernel/patches/sdm845/${filename}");

    qcom-defconfig =
      pkgs:
      (pkgs.runCommand "qcom-defconfig" { } ''
        cp ${inputs.linux-sdm845}/arch/arm64/configs/defconfig defconfig
        cp ${inputs.linux-sdm845}/arch/arm64/configs/sdm845.config sdm845.config
        cat defconfig sdm845.config > $out
      '');
  };
}

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

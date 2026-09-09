{ inputs, self, ... }:
{
  kernel.patches = {
    qcom = { }: [ "${self}/modules/kernel/patches/sdm845/sdm845-combined.patch" ];
    /*
      "${self}/modules/kernel/patches/sdm845"
      |> builtins.readDir
      |> builtins.attrNames
      |> map (filename: "${filename}.patch");
    */

    qcom-defconfig =
      pkgs:
      (pkgs.runCommand "qcom-defconfig" { } ''
        cp ${inputs.linux-sdm845}/arch/arm64/configs/defconfig defconfig
        cp ${inputs.linux-sdm845}/arch/arm64/configs/sdm845.config sdm845.config
        cat defconfig sdm845.config > $out
      '');
  };
}

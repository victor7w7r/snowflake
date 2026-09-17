{ inputs, pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "oneplus-firmware";
  version = "latest";
  src = inputs.oneplus;
  src2 = inputs.firmware;

  buildPhase = ''
    mkdir -p $out/lib/firmware
    cp -r $src/lib/firmware/* $out/lib/firmware/
    chmod +w -R $out
    cp $src2/qcom/a630_sqe.fw $out/lib/firmware/qcom/
    cp $src2/qcom/a630_gmu.bin $out/lib/firmware/qcom/
    rm -rf $out/lib/firmware/postmarketos
    cp -r $src/lib/firmware/postmarketos/* $out/lib/firmware
    ls -lah $out/lib/firmware/qcom/sdm845
  '';
}

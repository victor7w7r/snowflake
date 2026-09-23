{ inputs, pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "oneplus-firmware";
  version = "latest";
  src = inputs.oneplus;

  src2 = pkgs.fetchurl {
    url = "https://gitlab.com/kernel-firmware/linux-firmware/-/raw/main/qcom/a630_sqe.fw?ref_type=heads";
    sha256 = "sha256-HCG1J9kYNIfMVQ2ruz9D5VXfWpd6Rhk0/GHwY1qaqQw=";
  };

  src3 = pkgs.fetchurl {
    url = "https://gitlab.com/kernel-firmware/linux-firmware/-/raw/main/qcom/a630_gmu.bin?ref_type=heads";
    sha256 = "sha256-2o2bGx9cGgsxHzJWcJO0go88gAMd2ENfkawTxmThc6Y=";
  };

  buildPhase = ''
    mkdir -p $out/lib/firmware
    cp -r $src/lib/firmware/* $out/lib/firmware/
    chmod +w -R $out
    cp $src2 $out/lib/firmware/qcom/a630_sqe.fw
    cp $src3 $out/lib/firmware/qcom/a630_gmu.bin
    rm -rf $out/lib/firmware/postmarketos
    cp -r $src/lib/firmware/postmarketos/* $out/lib/firmware
    ls -lah $out/lib/firmware/qcom/sdm845
  '';
}

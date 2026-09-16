{ inputs, pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "oneplus-firmware";
  version = "latest";
  src = inputs.oneplus;

  installPhase = ''
    mkdir -p $out/lib/firmware
    cp -r $baseFw/lib/firmware/* $out/lib/firmware/
    chmod +w -R $out
    rm -rf $out/lib/firmware/postmarketos
    cp -r $baseFw/lib/firmware/postmarketos/* $out/lib/firmware
    ls -lah $out/lib/firmware/qcom/sdm845
  '';
}

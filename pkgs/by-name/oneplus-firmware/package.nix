{ inputs, pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "oneplus-firmware";
  version = "latest";
  src = inputs.oneplus;

  buildPhase = ''
    mkdir -p $out/lib/firmware
    cp -r $src/lib/firmware/* $out/lib/firmware/
    chmod +w -R $out
    rm -rf $out/lib/firmware/postmarketos
    cp -r $src/lib/firmware/postmarketos/* $out/lib/firmware
    ls -lah $out/lib/firmware/qcom/sdm845
  '';
}

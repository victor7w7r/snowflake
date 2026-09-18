{ inputs, pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "oneplus-config";
  version = "latest";
  src = inputs.oneplus;

  buildPhase = ''
    mkdir -p "$out/share/qcom/sdm845/OnePlus"
    cp -r $src/usr/share/qcom/sdm845/OnePlus/oneplus6 "$out/share/qcom/sdm845/OnePlus/oneplus6"
    ln -s oneplus6 "$out/share/qcom/sdm845/OnePlus/fajita"
  '';
}

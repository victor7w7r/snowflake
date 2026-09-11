{ inputs, pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  name = "firmware-oneplus-sdm845";
  src = inputs.oneplus;
  patches = [
    (pkgs.fetchpatch {
      name = "0001-oneplus6-set-mount-matrix.patch";
      url = "https://gitlab.postmarketos.org/postmarketOS/pmaports/-/raw/f1e277695bd09b69ebd49dce8834ae9bd4f60d9c/device/community/firmware-oneplus-sdm845/0001-oneplus6-set-mount-matrix.patch?inline=false";
      hash = "sha256-kuxEve7dTBH78ojp0AA5RECSnitf8Ns6/DR1ikCLuJo=";
    })
  ];

  dontBuild = true;
  dontFixup = true;

  installPhase = ''
	  while IFS="" read -r _i || [ -n "$_i" ]; do
	    install -Dm644 "$_i" "$out/''${_i/"postmarketos"/}"
	  done < "${./firmware.files}"

	  while IFS="" read -r _i || [ -n "$_i" ]; do
	    install -Dm644 "$_i" "$out/''${_i#"./usr"}"
	  done < "${./sensor.files}"

	  ln -s oneplus6 $out/share/qcom/sdm845/OnePlus/enchilada
	  ln -s oneplus6 $out/share/qcom/sdm845/OnePlus/fajita
  '';
}

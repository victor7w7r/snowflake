{ pkgs }:
(pkgs.stdenvNoCC.mkDerivation (final: {
  name = "brcm-firmware";
  src = ./custom/bcrm-firmware.tar;

  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/lib/firmware/brcm
    tar -xf ${final.src} -C $out/lib/firmware/brcm
  '';
}))

{ stdenvNoCC }:
stdenvNoCC.mkDerivation (final: {
  name = "brcm-firmware";
  src = ./bcrm.tar.gz;

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/lib/firmware/brcm
    tar -xvf ${final.src} -C $out/lib/firmware/brcm
  '';
})

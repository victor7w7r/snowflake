{ fetchurl, stdenv }:
stdenv.mkDerivation {
  pname = "udefrag";
  version = "latest";
  #https://aur.archlinux.org/packages/udefrag
  src = fetchurl {
    url = "http://jp-andre.pagesperso-orange.fr/ultradefrag-5.0.0AB.8.zip";
    sha256 = "sha256-9mk5SgkmaO6qAA/49WvDwvr0BsPnddEeQX0GWgFNDEk=";
  };

  prePatch = ''
    patch -p 1 -i udefrag.patch
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp udefrag $out/bin
  '';

}

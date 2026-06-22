{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-futurama";
  version = "latest";

  src = pkgs.fetchurl {
    url = "http://www.netmeister.org/apps/fortune-mod-futurama-0.2.tar.gz";
    sha256 = "sha256-/z0Pvz0IKPy8wCL9APnBZ85b9I26f2T0eDHL4vO3mkU=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    strfile futurama futurama.dat
    install -dm755 -- "$out/share/fortune"
    install -m644 -- futurama futurama.dat "$out/share/fortune"
  '';
})

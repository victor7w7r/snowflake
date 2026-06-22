{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-starwars";
  version = "latest";

  src = pkgs.fetchurl {
    url = "http://www.splitbrain.org/_media/projects/fortunes/fortune-starwars.tgz";
    sha256 = "sha256-LTUYLpSWvFgAA9ttJjbhjwTit4u/xupR0EkkhyhZgpo=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    install -m644 -- starwars* "$out/share/fortune"
  '';
})

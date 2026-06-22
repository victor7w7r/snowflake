{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-confucius";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://billy.wolfe.casa/fortunes/confucius";
    sha256 = "sha256-/z0Pvz0IKPy8wCL9APnBZ85b9IAAAAT0eDHL4vO3mkU=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src confucius
    strfile confucius
    install -dm755 -- "$out/share/fortune"
    install -m644 -- confucius confucius.dat "$out/share/fortune"
  '';
})

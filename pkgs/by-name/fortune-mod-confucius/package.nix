{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-confucius";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://billy.wolfe.casa/fortunes/confucius";
    sha256 = "sha256-MX6wMBwu8X+9sqHWey3MrnehyDZdofK1/EsWuggzI90=";
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

{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-limetricks";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://billy.wolfe.casa/fortunes/limericks";
    sha256 = "sha256-RPwzGd8EZ6t4z8I/rjnq+GtlSIMmMKnNj3yE9bJe5zc=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src limericks
    strfile limericks
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- limericks limericks.dat "$out/share/games/fortunes"
  '';
})

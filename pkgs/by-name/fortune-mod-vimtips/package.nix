{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-vimtips";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/hobbestigrou/vimtips-fortune/master/fortunes/vimtips";
    sha256 = "sha256-6lp1igOaDXqSj/sAAAxwlMPZ+FnpIc3rEUMFZv45hoI=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    strfile -r vimtips
    install -dm755 -- "$out/share/fortune"
    install -m644 -- vimtips vimtips.dat "$out/share/fortune"
  '';
})

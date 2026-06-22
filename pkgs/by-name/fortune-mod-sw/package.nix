{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-protolol";
  version = "2.17";

  src = pkgs.fetchurl {
    url = "https://mirror.slackbuilds.org/slackware/slackware64-15.0/slackware64/y/bsd-games-${attrs.version}-x86_64-3.txz";
    sha256 = "sha256-NXpovMrJXpAgvTxAAAzlQ0qMyloaBQW3MGIob/0pRiU=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    ls .
    install -dm755 -- "$out/share/fortune"
    install -m644 -- test test.dat "$out/share/fortune"
  '';
})

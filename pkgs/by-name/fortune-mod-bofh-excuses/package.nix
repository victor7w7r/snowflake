{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-bofh-excuses";
  version = "latest";

  src = pkgs.fetchurl {
    url = "http://www.cs.wisc.edu/~ballard/bofh/bofh-excuses.raw";
    sha256 = "sha256-crSulWD6AAas9EmQygQdw0QHemwHEG7togYuVHoSDtA=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src bofh-excuses.raw
    ${pkgs.awk}/bin/awk '{ printf "BOFH excuse #%d:\n\n%s\n%%\n", FNR, $0 }' \
      bofh-excuses.raw > bofh-excuses
    strfile bofh-excuses
    install -dm755 -- "$out/share/fortune"
    install -m644 -- bofh-excuses bofh-excuses.dat "$out/share/fortune"
  '';
})

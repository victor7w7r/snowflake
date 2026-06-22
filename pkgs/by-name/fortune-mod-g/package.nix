{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "gfortune";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "ketogenesis";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-rHpuZq4RzwL8YNg/sdJBjmIgnD1NfzVAJEMURT9FmpM=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    ${pkgs.bsdgames}/bin/caesar 13 < gsource > g
    strfile -x g g.dat
    install -m644 -- g g.dat "$out/share/fortune"
  '';
})

{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-protolol";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "virtualtam";
    repo = "fortune-protolol";
    rev = attrs.version;
    sha256 = "sha256-uYyodVXJFA9ZKWAAALJoMYTuAK2qHBgnu6nRxWJKrdU=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    install -m644 -- protolol protolol.dat "$out/share/fortune"
  '';
})

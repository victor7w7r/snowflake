{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-anti-jokes";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "dh-nunes";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-bZcDUU249FlsGrYA3BBjirJ5F7PjXXZzs2DXFsIBeCo=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    strfile -r anti-jokes
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- anti-jokes anti-jokes.dat "$out/share/games/fortunes"
  '';
})

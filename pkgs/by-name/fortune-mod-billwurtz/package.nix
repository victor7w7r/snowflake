{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-billwurtz";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "Ev1lbl0w";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-bZcDUU249FlsGrYA3BDDDrJ5F7PjXXZzs2DXFsIBeCo=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    install -m644 -- billwurtz billwurtz.dat "$out/share/fortune"
  '';
})

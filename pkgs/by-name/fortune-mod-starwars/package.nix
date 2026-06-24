{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-starwars";
  version = "latest";

  src = pkgs.fetchurl {
    url = "http://www.splitbrain.org/_media/projects/fortunes/fortune-starwars.tgz";
    sha256 = "sha256-zNuzV+v1R4JXFxaCYfVDUw/2E8IyIX1jrWZHXkYAbHg=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- starwars* "$out/share/games/fortunes"
  '';
})

{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-issa-haiku";
  version = "latest";

  src = pkgs.fetchurl {
    url = "http://www.tastyrabbit.net/issa-haiku.tar.gz";
    sha256 = "sha256-zNuzV+v1R4JXFxaCYfVDUw/2E8IyIAAArWZHXkYAbHg=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    install -m644 -- issa-haiku issa-haiku.dat "$out/share/fortune"
  '';
})

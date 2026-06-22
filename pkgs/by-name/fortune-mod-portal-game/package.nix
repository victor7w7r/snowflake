{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-portal-game";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "outadoc";
    repo = "portal-fortunes";
    rev = attrs.version;
    sha256 = "sha256-rHpuZq4RzwL8YNAAAdJBjmIgnD1NfzVAJEMURT9FmpM=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    install -m644 -- fortunes* "$out/share/fortune"
  '';
})

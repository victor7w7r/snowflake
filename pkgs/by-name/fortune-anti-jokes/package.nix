{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-anti-jokes";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "gdelugre";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-QDIk2A7CUP+kfSSSgx36PcAco96741aVysoFsihJQjM=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    strfile -r anti-jokes
    install -dm755 -- "$out/share/fortune"
    install -m644 -- anti-jokes anti-jokes.dat "$out/share/fortune"
  '';
})

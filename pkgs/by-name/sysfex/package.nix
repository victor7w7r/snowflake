{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "sysfex";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "mehedirm6244";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-oxlDQu4afhOAAA5HFS1h18+gN6ntlMK0iEIcbU9iqms=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  buildInputs = with pkgs; [
  ];

})

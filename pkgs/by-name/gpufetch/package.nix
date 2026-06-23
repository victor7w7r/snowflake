{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "gpufetch";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "Dr-Noob";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-QDIk2A7CUP+kfEAAgx36PcAco96741aVysoFsihJQjM=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

})

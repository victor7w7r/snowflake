{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "ext4-crypt";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "gdelugre";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-QDIk2A7CUP+kfEWYgx36PcAco96741aVysoFsihJQjM=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    keyutils
    libsodium
    pkg-config
  ];

  postPatch = ''
    sed -i '1,2d' CMakeLists.txt
    sed -i '1i cmake_minimum_required(VERSION 3.5)\nproject(${attrs.pname})' CMakeLists.txt
  '';

  cmakeFlags = [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];

  installPhase = ''
    mkdir -p $out/bin
    cp ext4-crypt $out/bin/
  '';
})

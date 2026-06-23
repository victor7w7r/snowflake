{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "gpufetch";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "Dr-Noob";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-oxlDQu4afhO0jm5HFS1h18+gN6ntlMK0iEIcbU9iqms=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  buildInputs = with pkgs; [
    pciutils
    zlib
  ];

  cmakeFlags = [
    "-DENABLE_INTEL_BACKEND=ON"
    "-DENABLE_CUDA_BACKEND=OFF"
    "-DENABLE_HSA_BACKEND=OFF"
    "-DCMAKE_SKIP_INSTALL_RPATH=ON"
  ];

  installPhase = ''
    mkdir -p $out/bin
    if [ -f "gpufetch" ]; then
      cp gpufetch $out/bin/gpufetch
    else
      cp bin/gpufetch $out/bin/gpufetch || find . -name gpufetch -exec cp {} $out/bin/ \;
    fi
  '';
})

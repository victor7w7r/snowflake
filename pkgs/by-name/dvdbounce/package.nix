{
  cmake,
  pkg-config,
  sfml_2,
  cxxopts,
  libx11,
  libxext,
  libxrender,
  fetchFromGitHub,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "master";
  version = "0.0.41";

  src = fetchFromGitHub {
    owner = "George-lewis";
    repo = "DVDBounce";
    rev = pname;
    sha256 = "sha256-S/0sc4Thj1gZGSOxl9bcY+VKcYGhEDi3HzPsBdhKatU=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    sfml_2
    cxxopts
    libx11
    libxext
    libxrender
  ];

  postPatch = ''
    sed -i '/conan/Id' CMakeLists.txt || true
    sed -i '/Conan/Id' CMakeLists.txt || true

    substituteInPlace src/config.cpp --replace "cxxopts::OptionException" "const std::exception&"

    cat << 'EOF' >> CMakeLists.txt
    find_package(SFML 2 REQUIRED COMPONENTS graphics window system)
    find_package(cxxopts REQUIRED)
    target_link_libraries(dvdbounce PRIVATE sfml-graphics sfml-window sfml-system cxxopts::cxxopts)
    EOF
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp dvdbounce $out/bin/ || cp bin/dvdbounce $out/bin/
    cp -r ../resources $out/bin/
  '';
}

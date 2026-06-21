{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "dvdbounce";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "George-lewis";
    repo = "DVDBounce";
    rev = attrs.version;
    sha256 = "sha256-S/0sc4Thj1gZGSOxl9bcY+VKcYGhEDi3HzPsBdhKatU=";
  };

  nativeBuildInputs = with pkgs; [ cmake ];

  buildInputs = with pkgs; [
    cxxopts
    libx11
    libxext
    libxrender
    sfml_2
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
})

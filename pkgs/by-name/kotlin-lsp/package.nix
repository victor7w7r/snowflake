{ pkgs, stdenvNoCC }:
let
  version = "263.7084.0";
  sources = {
    "x86_64-linux" = {
      url = "https://download.jetbrains.com/language-server/kotlin-server/${version}/kotlin-server-${version}.tar.gz";
      sha256 = "sha256-rgxLAeF6tzpKUienjqmebcvj5JlgAxWyJ1mk5M3dEd8=";
    };
    "aarch64-linux" = {
      url = "https://download.jetbrains.com/language-server/kotlin-server/${version}/kotlin-server-${version}-aarch64.tar.gz";
      sha256 = "sha256-UJmZAe+Lz6HlhWG2qNeCpD3qViD8+SpkEwgH+JJKVvw=";
    };
  };

  selectedSource =
    sources.${pkgs.stdenv.hostPlatform.system}
      or (throw "Unsupported system: ${pkgs.stdenv.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "kotlin-lsp";
  inherit version;

  src = pkgs.fetchurl {
    inherit (selectedSource) url sha256;
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = with pkgs; [
    jdk21
    zlib
    stdenv.cc.cc.lib
    libX11
    libXext
    libXrender
    libXi
    libXtst
    libXxf86vm
    libxkbcommon
    wayland
    fontconfig
    freetype
    alsa-lib
  ];

  dontStrip = true;

  installPhase = ''
    mkdir -p $out/libexec
    cp -r . $out/libexec/kotlin-lsp
    install -d $out/bin
    makeWrapper $out/libexec/kotlin-lsp/bin/intellij-server $out/bin/intellij-server \
      --set JAVA_HOME ${pkgs.jdk21}/lib/openjdk \
      --suffix PATH : ${pkgs.jdk21}/bin
    ln -s intellij-server $out/bin/kotlin-lsp
  '';
}

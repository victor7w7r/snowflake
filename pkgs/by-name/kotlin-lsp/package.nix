{ pkgs, stdenvNoCC }:
let
  version = "263.6379.0";
  sources = {
    "x86_64-linux" = {
      url = "https://download-cdn.jetbrains.com/language-server/kotlin-server/${version}/kotlin-server-${version}.tar.gz";
      sha256 = "sha256-q4ykRV3C/F/hok2yvMxGwQQlTSxGUVXEJR7mXfjz98w=";
    };
    "aarch64-linux" = {
      url = "https://download-cdn.jetbrains.com/language-server/kotlin-server/${version}/kotlin-server-${version}-aarch64.tar.gz";
      sha256 = "sha256-UJmZAe+Lz6HlhWG2qNeCpy3qViD8+SpkEwgH+JJKVvw=";
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
    makeWrapper
    unzip
  ];

  unpackPhase = ''
    case "${selectedSource.url}" in
      *.tar.gz) tar -xzf $src ;;
      *) unzip $src ;;
    esac
  '';

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin $out/share/kotlin-lsp
    cp -r kotlin-server-${version}/* $out/share/kotlin-lsp/
    chmod +x $out/share/kotlin-lsp/bin/intellij-server
    ${
      if pkgs.stdenv.hostPlatform.isDarwin then
        ''
          chmod +x $out/share/kotlin-lsp/jbr/Contents/Home/bin/java
        ''
      else
        ''
          chmod +x $out/share/kotlin-lsp/jbr/bin/java
        ''
    }

    makeWrapper $out/share/kotlin-lsp/bin/intellij-server $out/bin/kotlin-lsp
  '';
}

{ pkgs, stdenvNoCC}:
stdenvNoCC.mkDerivation (attrs: {
  pname = "kotlin-lsp";
  version = "263.4702.0";

  src = pkgs.fetchzip {
    url = "https://download-cdn.jetbrains.com/language-server/kotlin-server/${attrs.version}/kotlin-server-${attrs.version}.tar.gz";
    sha256 = "sha256-v7afkhXixaB2nSqhuyMhr0z5/biodUl5uuHJyMoBciQ=";
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
    autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    jdk25
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    mkdir -p $out/bin $out/share/kotlin-lsp
    cp -r bin build.txt kotlin-lsp.sh lib license modules plugins product-info.json $out/share/kotlin-lsp
    ln -s ${pkgs.jdk25}/lib/openjdk $out/share/kotlin-lsp/jbr

    makeWrapper $out/share/kotlin-lsp/bin/intellij-server $out/bin/kotlin-lsp
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    req='{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"processId":null,"rootUri":null,"capabilities":{}}}'
    printf 'Content-Length: %d\r\n\r\n%s' "''${#req}" "$req" \
      | timeout 120 $out/bin/kotlin-lsp --stdio > response.txt 2>/dev/null || true

    grep -q '"jsonrpc"' response.txt || {
      echo "kotlin-lsp did not respond to an LSP initialize request" >&2
      exit 1
    }
  '';
})

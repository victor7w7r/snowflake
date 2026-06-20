{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "chkufsd";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://archive.org/download/tools_202401/tools.zip";
    sha256 = "sha256-9mk5SgkmaO6qcv/49WvDwvr0BsPnddEeQAAGWgFNDEk=";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 "./disk tools/chkufsd" -t "$out/bin"
    ln -s "chkufsd" "$out/bin/chkntfs"
    ln -s "chkufsd" "$out/bin/chkhfs"
  '';
}

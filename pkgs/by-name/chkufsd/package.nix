{
  pkgs,
  stdenvNoCC,
  unzip,
}:
stdenvNoCC.mkDerivation {
  pname = "chkufsd";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://archive.org/download/tools_202401/tools.zip";
    sha256 = "sha256-lINfV2LeKf68voizc16v4XrbGZe2tIT2s5x6FEdqk2w=";
  };

  nativeBuildInputs = [ unzip ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    unzip $src
    install -Dm755 "./disk tools/chkufsd" -t "$out/bin"
    ln -s "chkufsd" "$out/bin/chkntfs"
    ln -s "chkufsd" "$out/bin/chkhfs"
  '';
}

{ stdenvNoCC, fetchurl }:
let
  url = "https://github.com/Code-Hex/Neo-cowsay/releases/download";
in
stdenvNoCC.mkDerivation rec {
  pname = "Neo-cowsay";
  version = "2.0.4";

  srcArm = fetchurl {
    url = "${url}/v${version}/cowsay_2.0.4_Linux_arm64.tar.gz";
    sha256 = "sha256-Mccde2h67SmrS7vKk29wDUwkWr/fVzvAFm5g31yYQ1A=";
  };

  srcAmd = fetchurl {
    url = "${url}/v${version}/cowsay_2.0.4_Linux_x86_64.tar.gz";
    sha256 = "sha256-31LmLOPBOYcf+NKr3qxUhKCshJidJiWib/pgH2Rw5QA=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin $out/cowsay
    tar -xvf ${if stdenvNoCC.hostPlatform.isAarch64 then "$srcArm" else "$srcAmd"} -C $out/cowsay
    mv $out/cowsay/cowsay $out/bin/ && mv $out/cowsay/cowthink $out/bin/
    rm -rf $out/cowsay
    chmod +x $out/bin/cowsay && chmod +x $out/bin/cowthink
  '';
}

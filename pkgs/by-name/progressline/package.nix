{ pkgs, stdenvNoCC }:
let
  url = "https://github.com/kattouf/ProgressLine/releases/download";
in
stdenvNoCC.mkDerivation (attrs: {
  pname = "progressline";
  version = "0.2.4";

  srcArm = pkgs.fetchurl {
    url = "${url}/${attrs.version}/progressline-0.2.4-aarch64-unknown-linux-gnu.zip";
    sha256 = "sha256-6aZuKn1LpsEhX23V9O2Y08zbZM2SckAh3R5uI+0isKE=";
  };

  srcAmd = pkgs.fetchurl {
    url = "${url}/${attrs.version}/progressline-0.2.4-x86_64-unknown-linux-gnu.zip";
    sha256 = "sha256-dr+U9v9WtZGrJGoQbRF29MIM5CvRO1+jjNTUJschGdM=";
  };

  nativeBuildInputs = with pkgs; [ unzip ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin $out/temp
    unzip ${if stdenvNoCC.hostPlatform.isAarch64 then "$srcArm" else "$srcAmd"} -d $out/temp
    mv $out/temp/progressline $out/bin/
    rm -rf $out/temp
    chmod +x $out/bin/progressline
  '';
})

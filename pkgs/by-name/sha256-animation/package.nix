{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "sha256-animation";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = " in3rsha";
    repo = attrs.pname;
    rev = attrs.version;
    hash = "sha256-OhaFS3pOdYeVR2sGjhixeC1wNNicdoTllmaDeXMabN4=";
  };

  buildInputs = with pkgs; [ ruby ];
  propagatedBuildInputs = with pkgs; [ ruby ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin

    for file in add blocks ch compression constants sha256 shr rotr sigma0 sigma1 usigma0 usigma1 ch maj; do
      cp $file.rb $out/bin/$file
      chmod +x $out/bin/$file
      sed -i '1i #!/usr/bin/env ruby' $out/bin/$file
    done

    patchShebangs $out/bin
  '';
})

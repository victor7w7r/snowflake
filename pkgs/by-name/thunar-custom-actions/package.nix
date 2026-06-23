{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "thunar-custom-actions";
  version = "0.0.22";

  src = pkgs.fetchFromGitLab {
    owner = "nobodyinperson";
    repo = pname;
    rev = "make-manpages-optional";
    sha256 = "sha256-RMmrx4fcYBLPIOtxUp3AIcF+S/4TV7gkcYvkEC2ixo0=";
  };

  m4UtilsSrc = pkgs.fetchFromGitLab {
    owner = "nobodyinperson";
    repo = "m4-utils";
    rev = "master";
    sha256 = "sha256-CAQsfygc/lFZpv6J96ZcFcsjhWXplCVLQEpLZ47O0kQ=";
  };

  nativeBuildInputs = with pkgs; [
    bc
    gettext
    ghostscript
    imagemagick
    gnupg
    makeWrapper
    perl
    su
    m4
    pinentry-gtk2
    xdg-utils
    zenity
  ];

  buildInputs = [
    (pkgs.python3.withPackages (ps: [ ps.lxml ]))
  ];

  postUnpack = ''
    rm -rf source/m4/m4-utils
    cp -r ${m4UtilsSrc} source/m4/m4-utils
    chmod -R +w source/m4/m4-utils
  '';

  configureFlags = [
    "--without-manpages"
    "PASSWDFILE=/etc/passwd"
  ];

  postFixup = with pkgs; ''
    for bin in "$out"/bin/*; do
      wrapProgram "$bin" \
        --prefix PATH : "${
          lib.makeBinPath [
            bc
            coreutils
            findutils
            ghostscript
            gnupg
            imagemagick
            m4
            perl
            pinentry-gtk2
            util-linux
            xdg-utils
            zenity
          ]
        }"
    done
  '';
}

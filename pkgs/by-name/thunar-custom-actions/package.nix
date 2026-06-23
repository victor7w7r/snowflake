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
    sha256 = "sha256-78o9TivzC2LAsB3h4254vYjAAAUnI+pE/FscGzKq7rE=";
  };

  m4UtilsSrc = pkgs.fetchFromGitLab {
    owner = "nobodyinperson";
    repo = "m4-utils";
    rev = "master";
    sha256 = "sha256-yZ3n9XN15P86p5bOon7S47l69AAAB65ZpW5vP7sL9gE=";
  };

  nativeBuildInputs = with pkgs; [
    gettext
    makeWrapper
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
            pinentry
            util-linux
            xdg-utils
            zenity
          ]
        }"
    done
  '';
}

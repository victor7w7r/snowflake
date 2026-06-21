{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "ffmpeg-audio-thumbnailer";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "saltedcoffii";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-mGhTcpmW0I/9amGep/0hXuoPkRsBaJIyNiFr6e9E0Is=";
  };

  buildInputs = with pkgs; [ ffmpeg ];

  makeFlags = [ "PREFIX=$(out)" ];
})

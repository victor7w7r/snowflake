{
  fetchFromGitHub,
  pkg-config,
  stdenv,
  ffmpeg,
}:
stdenv.mkDerivation rec {
  pname = "ffmpeg-audio-thumbnailer";
  version = "main";

  src = fetchFromGitHub {
    owner = "saltedcoffii";
    repo = pname;
    rev = version;
    sha256 = "sha256-mGhTcpmW0I/9amGep/0hXuoPkRsBaJIyNiFr6e9E0Is=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [ ffmpeg ];

  makeFlags = [ "PREFIX=$(out)" ];
}

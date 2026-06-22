{ pkgs, stdenv }:

stdenv.mkDerivation (attrs: {
  pname = "davinci-video-converter";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "tkmxqrdxddd";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-MkmW1RfhesgN34d4rQFAAAGJPBAyWi5RImGyBzZafNI=";
  };

  # nativeBuildInputs = with pkgs; [pkg-config ];

  buildInputs = with pkgs; [ ffmpeg ];

  makeFlags = [ "PREFIX=$(out)" ];
})

{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "davinci-video-converter";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "tkmxqrdxddd";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-EDQi6KVCrzJcVfuDwBRf7wN2BqVAY2q4XB9Le6dy4CU=";
  };

  makeFlags = [ "PREFIX=$(out)" ];

  # nativeBuildInputs = with pkgs; [pkg-config ];
  postPatch = ''
    substituteInPlace Makefile \
      --replace-fail "/usr/local/bin/" "''$out/bin/"
  '';

  preInstall = ''mkdir -p "$out/bin"'';
  buildInputs = with pkgs; [ ffmpeg ];
})

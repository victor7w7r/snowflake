{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "ncmatrix";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "tree-s";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-0p7++CVxUnRLjwYj5w+SxYkrASFyol1KPWZ/zUzc3ws=";
  };

  postPatch = ''
    touch AUTHORS ChangeLog NEWS README
    ln -s ncmatrix.c cmatrix.c
    ln -s ncmatrix.1 cmatrix.1
  '';

  nativeBuildInputs = with pkgs; [
    autoreconfHook
    automake
    autoconf
  ];

  buildInputs = with pkgs; [ ncurses ];
})

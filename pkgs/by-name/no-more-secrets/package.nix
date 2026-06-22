{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "no-more-secrets";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "bartobri";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-1zTVEGCtSH3E1ZNM6iWSH7eEXQM0UUyUOgzhvUuet08=";
  };

  buildInputs = with pkgs; [ ncurses ];

  nativeBuildInputs = with pkgs; [
    autoconf
    automake
  ];

  makeFlags = [ "prefix=${placeholder "out"}" ];

  buildFlags = [
    "nms-ncurses"
    "sneakers-ncurses"
  ];
})

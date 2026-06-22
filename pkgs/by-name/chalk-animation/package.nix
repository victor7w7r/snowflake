{ buildNpmPackage, pkgs }:
buildNpmPackage (attrs: {
  pname = "chalk-animation";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "bokub";
    repo = attrs.pname;
    rev = attrs.version;
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  npmDepsHash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";

  postInstall = ''
    mkdir -p $out/bin
    ln -s $out/lib/node_modules/chalk-animation/cli.js $out/bin/chalk-animation
    chmod +x $out/bin/chalk-animation
  '';
})

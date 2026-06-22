{ buildNpmPackage, pkgs }:
buildNpmPackage (attrs: {
  pname = "chalk-animation";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "bokub";
    repo = attrs.pname;
    rev = attrs.version;
    hash = "sha256-OhaFS3pOdYeVR2sGjhixeC1wNNicdoTllmaDeXMabN4=";
  };

  dontNpmBuild = true;

  npmDepsHash = "sha256-7kIH6e4cbp6Uw1JJmHXhgS9IBW9LzkEBdKEEiRDOYvQ=";

  postInstall = ''
    mkdir -p $out/bin
    chmod +x $out/bin/chalk-animation
  '';
})

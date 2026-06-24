{ fetchFromGitHub, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "aerofetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "driizzyy";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-QXNkKGSolReq6F0PnNfBHj2RbwC6+8qgNUD4rJZXWBU=";
  };

  dontBuild = true;
  installPhase = "mkdir -p $out/bin && install -Dm755 AeroFetch.sh $out/bin/aerofetch";
})

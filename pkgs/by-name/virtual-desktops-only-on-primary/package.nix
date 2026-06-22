{ fetchFromGitHub, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "virtual-desktops-only-on-primary";
  version = "master";

  src = fetchFromGitHub {
    owner = "Ubiquitine";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-zC096vsVCyDAEFpASU2gj0qRgWKYR1m9G6hPZL+61Wo=";
  };

  installPhase = ''
    mkdir -p $out/share/kwin/scripts/virtual-desktops-only-on-primary
    cp -r * $out/share/kwin/scripts/virtual-desktops-only-on-primary/
  '';
})

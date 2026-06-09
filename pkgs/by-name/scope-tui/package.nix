{
  alsa-lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libX11,
  libXext,
  libXrender,
}:
rustPlatform.buildRustPackage rec {
  pname = "scope-tui";
  version = "dev";

  src = fetchFromGitHub {
    owner = "alemidev";
    repo = pname;
    rev = version;
    sha256 = "sha256-LR6PmyJQNgtuPXQVorsCNEX6dXU6MG1dD8F0dUd3h4M=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    alsa-lib
    libX11
    libXext
    libXrender
  ];

  cargoHash = "sha256-3GbZnmjwddX+2/7UGO1CIQV3CT/HogSa/JusgDzy4Ow=";
}

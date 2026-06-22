{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "lifecycler";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "cxreiff";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-FvMBIUS7SFpvJQcDL29c50itaLOW0c3W5ktgCbELD+g=";
  };

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [
    alsa-lib
    udev
  ];

  cargoHash = "sha256-jUcYyp+hMcdgWkdSf3DywSscGff9DpQ1Dt0pgEiP930=";
})

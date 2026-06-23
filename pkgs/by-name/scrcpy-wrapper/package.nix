{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "scrcpy-wrapper";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "Bluemangoo";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-68Mrdh8OtVJbC2UP+TqjLajmubXRdrHcjszw5ZfWJA8=";
  };

  cargoHash = "sha256-o48iriH7rRsi3XM+dhnrs2HbRAKv82RtiEEG2DPSJjo=";

  nativeBuildInputs = with pkgs; [
    pkg-config
    makeWrapper
  ];

  buildInputs = with pkgs; [
    wayland
    libxkbcommon
    libGL
    libX11
    libXcursor
    libXrandr
    libXi
  ];

  postInstall = ''
    wrapProgram $out/bin/${attrs.pname} \
      --prefix LD_LIBRARY_PATH : "${
        pkgs.lib.makeLibraryPath (
          with pkgs;
          [
            wayland
            libxkbcommon
            libGL
            libX11
            libXcursor
            libXrandr
            libXi
          ]
        )
      }"
  '';
})

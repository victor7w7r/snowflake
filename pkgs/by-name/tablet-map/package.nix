{
  fetchFromGitHub,
  pkg-config,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "tablet_map";
  version = "main";

  src = fetchFromGitHub {
    owner = "victor7w7r";
    repo = pname;
    rev = version;
    sha256 = "sha256-kA+LCoffX7+xnvi3xEweeP8a9uXimYU7trwM6zDMBhw=";
  };

  cargoHash = "sha256-8aPasJIznPhBC4jrX+9rX81M9EyDjtmhaMd4NZKxQwc=";

  nativeBuildInputs = [
    pkg-config
    #pkgs.sccache
  ];

  installPhase = ''
    mkdir -p $out/bin
    ls -lah ./target/x86_64-unknown-linux-gnu/release
    install -m755 -D target/x86_64-unknown-linux-gnu/release/tablet_map $out/bin/tablet_map
  '';

  #RUSTC_WRAPPER = "sccache";
  #SCCACHE_DIR = "/nix/var/cache/sccache";

}

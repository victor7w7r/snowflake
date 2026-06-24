{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "linuxthemestore";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "debasish-patra-1987";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-MkmW1RfhesgN34d4rQFypdGJPBAyWi5RImGyBzZafNI=";
  };

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [
    gdk-pixbuf
    glib
    gtk4
    libadwaita
    openssl
    pango
  ];

  cargoHash = "sha256-nmgxSe+Qs8hXjMd8ENItGkCFuPGzF/Opa33H/kyHcb0=";
})

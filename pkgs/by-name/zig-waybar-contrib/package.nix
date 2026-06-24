{ pkgs, stdenv }:

stdenv.mkDerivation (attrs: {
  pname = "zig-waybar-contrib";
  version = "0.17.x";

  src = pkgs.fetchFromGitea {
    domain = "codeberg.org";
    owner = "erffy";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = with pkgs; [
    zig_0_13.hook
  ];

  zigBuildFlags = [ "-Doptimize=ReleaseSafe" ];

  postInstall = ''
    mkdir -p $out/share/zig-waybar-contrib
    sed -i "s|{{EXECUTABLE_PATH}}|$out/bin|g" config.waybar.jsonc
    cp config.waybar.jsonc $out/share/zig-waybar-contrib/config.jsonc
  '';
})

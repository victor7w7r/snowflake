{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "waybar-media";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "yurihs";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Fxs/a/Zk3orMYbT3noxWbub7wOtiwZFhbpbgGW7UUgI=";
  };

  nativeBuildInputs = with pkgs; [ makeWrapper ];
  buildInputs = with pkgs; [ python3 ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp waybar-media.py $out/bin/waybar-media
    chmod +x $out/bin/waybar-media
    wrapProgram $out/bin/rofi-tmux \
      --prefix PYTHONPATH : "${pkgs.python3.pkgs.makePythonPath [ pkgs.python3.pkgs.click ]}" \
      --prefix PATH : "${pkgs.lib.makeBinPath [ pkgs.python3 ]}"
  '';
})

{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "waybar-dunst";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "CelDaemon";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-7L/HNLY94qYriI6PeoDyyeq4H+NcyxGTR45Z8I03drs=";
  };

  nativeBuildInputs = with pkgs; [ makeWrapper ];
  buildInputs = with pkgs; [
    python3
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp waybar-dunst $out/bin/waybar-dunst
    chmod +x $out/bin/waybar-dunst
    wrapProgram $out/bin/waybar-dunst \
      --prefix PYTHONPATH : "${
        pkgs.python3.pkgs.makePythonPath [
          pkgs.python3.pkgs.dbus-fast
          pkgs.python3.pkgs.pygobject3
        ]
      }" \
      --prefix PATH : "${pkgs.lib.makeBinPath [ pkgs.python3 ]}"
  '';
})

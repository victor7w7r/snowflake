{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "waybar-dunst";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "CelDaemon";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-carRNsgQFGUzlAAALU5+M1xPU6aSQZgoHlC88W/CULk=";
  };

  nativeBuildInputs = with pkgs; [ makeWrapper ];
  buildInputs = with pkgs; [
    python3
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp waybar-dunst.py $out/bin/waybar-dunst
    chmod +x $out/bin/waybar-dunst
    wrapProgram $out/bin/waybar-dunst \
      --prefix PYTHONPATH : "${
        pkgs.python3.pkgs.makePythonPath [
          pkgs.python3.pkgs.pygobject3
        ]
      }" \
      --prefix PATH : "${pkgs.lib.makeBinPath [ pkgs.python3 ]}"
  '';
})

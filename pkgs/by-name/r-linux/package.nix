{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "r-linux";
  version = "6.5.191754";

  src = pkgs.fetchurl {
    url = "https://www.r-studio.com/downloads/RLinux6_x64.deb";
    sha256 = "sha256-dr+U9v9WtZGrJGoQbRF29MIM5CvAAA+jjNTUJschGdM=";
  };

  nativeBuildInputs = with pkgs; [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = with pkgs; [
    xorg.libX11
    xorg.libXext
    alsa-lib
    glib
    fontconfig
    freetype
  ];

  unpackCmd = "dpkg-deb -x $src .";
  dontBuild = true;
  installPhase = ''
        mkdir -p "$out/opt"
        mkdir -p "$out/bin"
        mkdir -p "$out/share/applications"
        mkdir -p "$out/share/pixmaps"

        cp -r usr/local/R-Linux "$out/opt/"

        head -n -12 "$out/opt/R-Linux/bin/rlinux" > "$out/opt/R-Linux/bin/rlinux.tmp"

        cat << 'EOF' >> "$out/opt/R-Linux/bin/rlinux.tmp"
    # Lógica inyectada de elevación
    if [ "$EUID" -ne 0 ]; then
        echo "Este programa requiere privilegios de root."
        # Aquí puedes llamar a pkexec o dejar que el usuario lo corra con sudo rlinux
    fi
    exec "$out/opt/R-Linux/bin/R-Linux" "$@"
    EOF

        mv "$out/opt/R-Linux/bin/rlinux.tmp" "$out/opt/R-Linux/bin/rlinux"
        chmod +x "$out/opt/R-Linux/bin/rlinux"

        substituteInPlace "$out/opt/R-Linux/bin/rlinux" \
          --replace "/usr/local" "$out/opt"

        ln -s "$out/opt/R-Linux/bin/rlinux" "$out/bin/rlinux"
        cp "$out/opt/R-Linux/share/logo_48.png" "$out/share/pixmaps/rtt-rlinux.png"
        substitute "$out/opt/R-Linux/share/rtt-rlinux.desktop" "$out/share/applications/rtt-rlinux.desktop" \
          --replace "/usr/local" "$out/opt"
  '';

  postFixup = ''
    wrapProgram "$out/bin/rlinux" \
      --prefix PATH : "${stdenv.lib.makeBinPath [ pkgs.xorg.xhost ]}"
  '';
})

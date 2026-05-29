  /*
    dolphin-quick-view = pkgs.stdenv.mkDerivation {
    pname = "kde-thumbnailer-apk";
    version = "1.0.0";
    src = pkgs.fetchFromGitLab {
      owner = "z3ntu";
      repo = "kde-thumbnailer-apk";
      rev = "HEAD";
      sha256 = lib.fakeSha256;
    };

    nativeBuildInputs = [
      pkgs.cmake
      pkg-config
    ];

    buildInputs = with pkgs; [
      (python312.withPackages (ps: [
        ps.pyside6
      ]))
      xclip
      wl-clipboard
      gnused
    ];

    configurePhase = "cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_INSTALL_LIBDIR=lib";
    buildPhase = "make -C build";
    installPhase = "make -C build install";
    };

    home.packages = [
      appimage-thumbnailer
      kf6-servicemenus-rootactions
      jar-thumbnailer
      kde-thumbnailer-apk
      ffmpeg-audio-thumbnailer
    ];
  */

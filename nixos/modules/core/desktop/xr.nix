{
  pkgs,
  system,
  inputs,
  ...
}:

let
  common = pkgs.stdenv.mkDerivation {
    pname = "breezy-desktop-common";
    version = "v2.9.12";

    src = pkgs.fetchFromGitHub {
      owner = "wheaney";
      repo = "breezy-desktop";
      rev = "v2.9.12";
      hash = "sha256-uAjA9YN82W8W951JRibFqC9nGZ4/8RU6hXPErrPsmTg=";
    };

    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      mkdir -p $out/share/breezy-desktop
      mkdir -p $out/share/icons/hicolor/scalable/apps
      cp VERSION $out/share/breezy-desktop/

      if [ -f ui/data/icons/hicolor/scalable/apps/com.xronlinux.BreezyDesktop.svg ]; then
        cp ui/data/icons/hicolor/scalable/apps/com.xronlinux.BreezyDesktop.svg $out/share/icons/hicolor/scalable/apps/
      fi
    '';
  };

  breezy-kwin = pkgs.stdenv.mkDerivation {
    pname = "breezy-desktop-kwin";
    version = "v2.9.12";

    src = pkgs.fetchFromGitHub {
      owner = "wheaney";
      repo = "breezy-desktop";
      rev = "v2.9.12";
      hash = "sha256-uAjA9YN82W8W951JRibFqC9nGZ4/8RU6hXPErrPsmTg=";
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/lib/qt6/plugins/kwin/effects/plugins/
      mkdir -p $out/lib/qt6/plugins/plasma/kcms/
      mkdir -p $out/share/applications/
      mkdir -p $out/share/icons/hicolor/scalable/apps/
      mkdir -p $out/bin

      touch $out/lib/qt6/plugins/kwin/effects/plugins/breezyfollow.so
      touch $out/lib/qt6/plugins/plasma/kcms/kcm_breezy_kwin_follow.so

      cat > $out/share/applications/kcm_breezy_kwin_follow.desktop << EOF
      [Desktop Entry]
      Name=Breezy KWin Follow
      Comment=Configure Breezy Desktop KWin integration
      Exec=kcmshell6 kcm_breezy_kwin_follow
      Icon=preferences-system-windows
      Type=Application
      X-KDE-ServiceTypes=KCModule
      X-KDE-Library=kcm_breezy_kwin_follow
      X-KDE-ParentApp=kcontrol
      X-KDE-System-Settings-Parent-Category=desktop
      X-KDE-Weight=50
      Categories=Qt;KDE;Settings;
      EOF

      cat > $out/share/applications/com.xronlinux.BreezyDesktop.desktop << EOF
      [Desktop Entry]
      Name=Breezy Desktop
      Comment=XR glasses desktop integration
      Exec=true
      Icon=${common}/share/icons/hicolor/scalable/apps/com.xronlinux.BreezyDesktop.svg
      Terminal=false
      Type=Application
      Categories=Utility;
      EOF

      cp ${common}/share/icons/hicolor/scalable/apps/com.xronlinux.BreezyDesktop.svg $out/share/icons/hicolor/scalable/apps/

      cat > $out/bin/breezy-desktop-kwin-setup << EOF
      #!/bin/sh
      # Enable KWin effect
      kwriteconfig6 --file kwinrc --group Plugins --key breezyfollowEnabled true
      # Start XR driver service
      systemctl --user enable --now xr-driver.service
      # Notify user to log out and back in
      echo "Please log out and back in to complete the setup."
      EOF
      chmod +x $out/bin/breezy-desktop-kwin-setup

      cat > $out/bin/breezy-desktop-kwin-uninstall << EOF
      #!/bin/sh
      # Disable KWin effect
      kwriteconfig6 --file kwinrc --group Plugins --key breezyfollowEnabled false
      # Stop XR driver service
      systemctl --user disable --now xr-driver.service
      # Notify user to log out and back in
      echo "Please log out and back in to complete the uninstallation."
      EOF
      chmod +x $out/bin/breezy-desktop-kwin-uninstall
    '';
  };
  xrlinux = pkgs.stdenv.mkDerivation {
    pname = "xrlinuxdriver";
    version = "2.1.5";

    src = inputs.xrlinux;

    nativeBuildInputs = with pkgs; [
      cmake
      pkg-config
      (python3.withPackages (ps: with ps; [ pyyaml ]))
      git
    ];

    buildInputs = with pkgs; [
      libusb1
      libevdev
      openssl
      json_c
      curl
      wayland
      libffi
    ];

    cmakeFlags = [
      "-DCMAKE_BUILD_TYPE=Release"
      "-DCMAKE_SKIP_BUILD_RPATH=OFF"
      "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON"
      "-DCMAKE_INSTALL_RPATH=$ORIGIN/../lib"
      "-DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON"
    ];

    prePatch = ''
      echo "# Default empty configuration" > custom_banner_config.yml
      echo "banners: []" >> custom_banner_config.yml
    '';

    postPatch = ''
      substituteInPlace CMakeLists.txt \
        --replace-fail "execute_process(COMMAND git submodule update --init --recursive" "execute_process(COMMAND echo \"Skipping git submodule update\""

      # Disable the XREAL device as we can't build it without the submodules
      echo "Removing xreal.c from SOURCES"
      substituteInPlace CMakeLists.txt \
        --replace-fail "    src/devices/xreal.c" ""

      # Modify devices.c to remove references to xreal_driver
      sed -i 's/&xreal_driver,/\/\* Disabled: \&xreal_driver, \*\//g' src/devices.c

      # Remove references to the xrealAirLibrary
      substituteInPlace CMakeLists.txt \
        --replace-fail "add_subdirectory(modules/xrealInterfaceLibrary/interface_lib)" "# Disabled"

      substituteInPlace CMakeLists.txt \
        --replace-fail "xrealAirLibrary" ""

      export UA_API_SECRET_INTENTIONALLY_EMPTY=1
    '';

    installPhase = ''
      mkdir -p $out/bin

      install -Dm755 xrDriver $out/bin/xrDriver

      mkdir -p $out/bin/bin/user
      for script in ../bin/xr_driver_*; do
        install -Dm755 $script $out/bin/
      done
      install -Dm755 ../bin/setup $out/bin/xr_driver_setup
      install -Dm755 ../bin/user/install $out/bin/bin/user/
      install -Dm755 ../bin/user/systemd_start $out/bin/bin/user/

      for file in $out/bin/xr_driver_* $out/bin/bin/user/*; do
        if [ -f "$file" ]; then
          substituteInPlace $file \
            --replace "realpath bin/" "$out/bin/bin/" \
            --replace "../bin/" "$out/bin/bin/" \
            --replace "./bin/" "$out/bin/bin/" || true
        fi
      done

      mkdir -p $out/lib/systemd/user
      cp -r ../systemd/* $out/lib/systemd/user/
      substituteInPlace $out/lib/systemd/user/xr-driver.service \
        --replace "{ld_library_path}" "$out/lib" \
        --replace "{bin_dir}" "$out/bin"

      mkdir -p $out/lib/udev/rules.d
      cp -r ../udev/* $out/lib/udev/rules.d/

      mkdir -p $out/lib
      cp -r ../lib/$(if [ "${system}" = "x86_64-linux" ]; then echo "x86_64"; else echo "aarch64"; fi)/*.so $out/lib/ || true
    '';

    fixupPhase = ''
      patchelf --set-rpath '$ORIGIN/../lib' $out/bin/xrDriver
    '';
  };
in
{
  environment.systemPackages = [
    breezy-kwin
    xrlinux
  ];
}

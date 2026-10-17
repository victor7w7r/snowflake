{
  cache-stdenv,
  inputs,
  pkgs,
}:
cache-stdenv.mkDerivation {
  pname = "kontainer";
  version = "latest";
  src = inputs.kontainer;

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace-fail "ecm_find_qmlmodule(org.kde.kirigami REQUIRED)" "ecm_find_qmlmodule(org.kde.kirigami)"
  '';

  nativeBuildInputs = with pkgs; [
    cmake
    ninja
    kdePackages.extra-cmake-modules
    qt6.wrapQtAppsHook
  ];

  qtWrapperArgs = [
    "--prefix PATH : ${
      pkgs.lib.makeBinPath [
        pkgs.distrobox
      ]
    }"
  ];

  buildInputs = with pkgs; [
    qt6.qtbase
    qt6.qtdeclarative
    kdePackages.kirigami
    kdePackages.kirigami-addons
    kdePackages.ki18n
    kdePackages.kcoreaddons
    kdePackages.qqc2-desktop-style
    kdePackages.kiconthemes
    kdePackages.kio
    git
  ];
}

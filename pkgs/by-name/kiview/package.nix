{
  cache-stdenv,
  inputs,
  pkgs,
}:
cache-stdenv.mkDerivation {
  pname = "kiview";
  version = "latest";
  src = inputs.kiview;
  nativeBuildInputs = with pkgs; [
    cmake
    kdePackages.extra-cmake-modules
    kdePackages.wrapQtAppsHook
    ninja
  ];

  buildInputs =
    with pkgs.kdePackages;
    [
      kcoreaddons
      ki18n
      kio
      kdbusaddons
      kirigami
      kirigami-addons
      qtbase
      qtdeclarative
      qtmultimedia
      qtwebengine
    ]
    ++ pkgs.lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.kdePackages.qtwayland;

  strictDeps = true;
}

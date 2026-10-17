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
      kirigami
      qtbase
      qtdeclarative
      qtwebengine
    ]
    ++ lib.optional stdenv.hostPlatform.isLinux kdePackages.qtwayland;

  strictDeps = true;
}

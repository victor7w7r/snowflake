{ cache-stdenv, pkgs }:
cache-stdenv.mkDerivation {
  pname = "iio-sensor-proxy";
  version = "3.9";

  src = pkgs.fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "hadess";
    repo = "iio-sensor-proxy";
    rev = "0085ddf8ecb173a1c5fcf2344aa40e561125354f";
    hash = "sha256-2N/4Fp6QtAhgEzX9cHEDJhFtRsyrtZ80I2jdHdeEmxA=";
  };

  postPatch = ''
    substituteInPlace data/meson.build \
      --replace-fail 'polkit_policy_directory' "'$out/share/polkit-1/actions'"
  '';

  doInstallCheck = true;

  buildInputs = with pkgs; [
    libgudev
    libssc
    polkit
    systemd
  ];

  nativeBuildInputs = with pkgs; [
    glib
    libxml2
    meson
    ninja
    pkg-config
    udevCheckHook
  ];

  mesonFlags = [
    (pkgs.lib.mesonOption "udevrulesdir" "${placeholder "out"}/lib/udev/rules.d")
    (pkgs.lib.mesonOption "systemdsystemunitdir" "${placeholder "out"}/lib/systemd/system")
    (pkgs.lib.mesonOption "ssc-support" "enabled")
  ];
}

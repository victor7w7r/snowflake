{ cache-stdenv, pkgs }:

cache-stdenv.mkDerivation {
  pname = "hexagonrpc";
  version = "0.4.0-unstable-2026-06-14";

  src = pkgs.fetchFromGitHub {
    owner = "linux-msm";
    repo = "hexagonrpc";
    rev = "dd9ac70c026e1bad93e8cffa3801255b8ceb551e";
    sha256 = "09hhasnfz53rwh10y2yqr402dzqsjiddzwz889xdlsm9daaiws8i";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
  ];

  buildInputs = with pkgs; [ json_c ];

  postInstall = ''
    mkdir -p $out/lib/systemd/system
    for unit in hexagonrpcd-adsp-rootpd hexagonrpcd-adsp-sensorspd hexagonrpcd-sdsp; do
      substitute "$NIX_BUILD_TOP/source/data/$unit.service.in" \
        "$out/lib/systemd/system/$unit.service" \
        --replace-fail '@bindir@' "$out/bin"
    done
  '';
}

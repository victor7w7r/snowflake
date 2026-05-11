{
  lib,
  pkgs,
  stdenv,
  kernel,
  kernelData,
  ...
}:
let
  version = rec {
    file = "${fetch.sdm845}/Makefile";
    version = toString (builtins.match ".+VERSION = ([0-9]+).+" (builtins.readFile file));
    patchlevel = toString (builtins.match ".+PATCHLEVEL = ([0-9]+).+" (builtins.readFile file));
    sublevel = toString (builtins.match ".+SUBLEVEL = ([0-9]+).+" (builtins.readFile file));
    extraversion = toString (builtins.match ".+EXTRAVERSION = ([a-z0-9-]+).+" (builtins.readFile file));
    string = "${
      version + "." + patchlevel + "." + sublevel + (lib.optionalString (extraversion != "") extraversion)
    }";
  };
  majorMinor = lib.versions.majorMinor version.string;
  isCross = stdenv.hostPlatform != stdenv.buildPlatform;
  fetch = (pkgs.callPackage ../fetch.nix { inherit kernelData majorMinor; });
  localVer = "-v7w7r-sdm845";
  config = (import ./config.nix);
  patches = [
    # "${fetch.patches}/${majorMinor}/misc/reflex-governor.patch"
    # "${fetch.patches}/${majorMinor}/misc/nap-governor.patch"
  ];
in
pkgs.stdenv.mkDerivation {
  inherit patches;
  src = fetch.sdm845;
  name = "linux-${majorMinor}${localVer}-config";

  nativeBuildInputs = kernel.nativeBuildInputs ++ kernel.buildInputs;
  installPhase = "cp .config $out";

  makeFlags = [
    "ARCH=arm64"
  ]
  ++ lib.optionals isCross [
    "CROSS_COMPILE=${stdenv.cc.targetPrefix}"
  ];

  buildPhase = ''
    cp arch/arm64/configs/sdm845.config .config
    patchShebangs scripts/config
    scripts/config ${lib.concatStringsSep " " config}
    scripts/config --undefine CONFIG_LOCALVERSION
    make $makeFlags olddefconfig
  '';

  meta = pkgs.linuxPackages.kernel.passthru.configfile.meta // {
    platforms = [ "aarch64-linux" ];
  };

  postPatch = ''
    sed -i 's/localversion_next=.*//' scripts/setlocalversion
    rm -rf  localversion-next
    echo "" > .scmversion
  '';

  passthru = {
    inherit localVer patches;
    version = version.string;
  };
}

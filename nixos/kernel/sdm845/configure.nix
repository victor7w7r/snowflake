{
  lib,
  pkgs,
  kernel,
  kernelData,
  ...
}:
let
  version = rec {
    string = "${
      version + "." + patchlevel + "." + sublevel + (lib.optionalString (extraversion != "") extraversion)
    }";
    file = "${fetch.sdm845}/Makefile";
    version = toString (builtins.match ".+VERSION = ([0-9]+).+" (builtins.readFile file));
    patchlevel = toString (builtins.match ".+PATCHLEVEL = ([0-9]+).+" (builtins.readFile file));
    sublevel = toString (builtins.match ".+SUBLEVEL = ([0-9]+).+" (builtins.readFile file));
    extraversion = toString (builtins.match ".+EXTRAVERSION = ([a-z0-9-]+).+" (builtins.readFile file));
  };
  majorMinor = lib.versions.majorMinor (builtins.trace version.string version.string);
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

  buildPhase = ''
    export ARCH=arm64

    cp arch/arm64/configs/sdm845.config .config
    patchShebangs scripts/config
    scripts/config ${lib.concatStringsSep " " config}
    scripts/config --undefine CONFIG_LOCALVERSION
    make ARCH=arm64 $makeFlags olddefconfig
  '';

  meta = pkgs.linuxPackages.kernel.passthru.configfile.meta // {
    platforms = [ "aarch64-linux" ];
  };

  passthru = {
    inherit localVer patches;
    version = version.string;
  };
}

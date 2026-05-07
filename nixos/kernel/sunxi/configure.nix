{
  lib,
  pkgs,
  kernel,
  kernelData,
  ...
}:
let
  majorMinor = lib.versions.majorMinor kernelData.linux.version;
  fetch = (pkgs.callPackage ../fetch.nix { inherit kernelData majorMinor; });
  localVer = "-v7w7r-sunxi-hardened";
  config = (import ./config.nix);
  modules = ./modules.db;

  patchesRoute = "${fetch.armbian}/patch/kernel/archive/sunxi-6.18";
  patchLines = lib.splitString "\n" (builtins.readFile "${patchesRoute}/series.conf");
  patchesList = lib.filter (line: line != "" && !(lib.hasPrefix "#" line || lib.hasPrefix "-" line)) (
    map lib.strings.trim patchLines
  );
  selectedPatches = map (path: [ "${patchesRoute}/${path}" ]) patchesList;

in

pkgs.stdenv.mkDerivation {
  src = fetch.linux;
  name = "linux-${majorMinor}${localVer}-config";

  nativeBuildInputs = kernel.nativeBuildInputs ++ kernel.buildInputs;
  installPhase = "cp .config $out";

  prePatch = ''
    ${import ./wifi-patch.nix { uwe5622 = fetch.uwe5622; }}
    ${import ./dts.nix { armbian = fetch.armbian; }}
  '';

  /*
    #cp "${./sunxi64.config}" ".config"
    #export LSMOD=$(mktemp)
    #cat "${modules}" | sort > $LSMOD
    #(yes "" | make LSMOD=$LSMOD localmodconfig) || true

    #make ARCH=arm64 $makeFlags olddefconfig
  */

  buildPhase = ''
    export ARCH=arm64

    cp ${./sunxi64.config} .config
    chmod -R +w .config
    patchShebangs scripts/config
    scripts/config ${lib.concatStringsSep " " config}
    make ARCH=arm64 $makeFlags olddefconfig
  '';

  meta = pkgs.linuxPackages.kernel.passthru.configfile.meta // {
    platforms = [ "aarch64-linux" ];
  };

  passthru = {
    inherit localVer;
    version = kernelData.linux.version;
  };
}

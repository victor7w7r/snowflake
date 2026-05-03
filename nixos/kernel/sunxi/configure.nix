{
  lib,
  pkgs,
  kernel,
  kernelData,
  ...
}:
let
  majorMinor = lib.versions.majorMinor kernelData.linux.version;
  fetch = (
    pkgs.callPackage ../fetch.nix {
      inherit kernelData majorMinor;
    }
  );
  localVer = "-v7w7r-sunxi-hardened";
  config = (import ./config.nix);
  modules = ./modules.db;

  patchesRoute = "${fetch.armbian}/patch/kernel/archive/sunxi-6.18";
  patchLines = lib.splitString "\n" (builtins.readFile "${patchesRoute}/series.conf");
  patchesList = lib.filter (line: line != "" && !(lib.hasPrefix "#" line || lib.hasPrefix "-" line)) (
    map lib.strings.trim patchLines
  );
  selectedPatches = map (path: [ "${patchesRoute}/${path}" ]) patchesList;

  wifiPatches = [
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-allwinner-v6.3.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-allwinner-bugfix-v6.3.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-allwinner-v6.3-compilation-fix.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.4-post.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-warnings.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-park-link-v6.1-post.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.1.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.6-fix-tty-sdio.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-fix-setting-mac-address-for-netdev.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/wireless-uwe5622-Fix-compilation-with-6.7-kernel.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/wireless-uwe5622-reduce-system-load.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.9.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.11.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-fix-spanning-writes.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-fix-timer-api-changes-for-6.15-only-sunxi.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.16.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.17.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.18.patch"
  ];

  patches =
    selectedPatches
    ++ wifiPatches
    ++ [
      "${fetch.patches}/${majorMinor}/misc/0001-hardened.patch"
      "${fetch.patches}/${majorMinor}/misc/reflex-governor.patch"
      "${fetch.patches}/${majorMinor}/misc/nap-governor.patch"
    ];
in

pkgs.stdenv.mkDerivation {
  inherit patches;
  src = fetch.linux;
  name = "linux-${majorMinor}${localVer}-config";

  nativeBuildInputs = kernel.nativeBuildInputs ++ kernel.buildInputs;
  installPhase = "cp .config $out";

  prePatch = ''
    ${import ./wifi-patch.nix { uwe5622 = fetch.uwe5622; }}
    ${import ./dts.nix { armbian = fetch.armbian; }}
  '';

  buildPhase = ''
    export ARCH=arm64

    cp "${./sunxi64.config}" ".config"
    export LSMOD=$(mktemp)
    cat "${modules}" | sort > $LSMOD
    (yes "" | make LSMOD=$LSMOD localmodconfig) || true

    make ARCH=arm64 $makeFlags olddefconfig
    patchShebangs scripts/config
    scripts/config ${lib.concatStringsSep " " config}
    make ARCH=arm64 $makeFlags olddefconfig
  '';

  meta = pkgs.linuxPackages.kernel.passthru.configfile.meta // {
    platforms = [ "aarch64-linux" ];
  };

  passthru = {
    version = kernelData.linux.version;
    inherit localVer patches;
  };
}

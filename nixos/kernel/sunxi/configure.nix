{
  lib,
  pkgs,
  stdenv,
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
  patchLines = lib.splitString "\n" (
    builtins.readFile "${fetch.armbian}/patch/kernel/archive/sunxi-6.18/series.conf"
  );
  patchesList = lib.filter (line: line != "" && !(lib.hasPrefix "#" line || lib.hasPrefix "-" line)) (
    map lib.strings.trim patchLines
  );
  selectedPatches = map (path: [ "${patchesRoute}/${path}" ]) patchesList;
  isCross = stdenv.hostPlatform != stdenv.buildPlatform;
  patches = [
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-warnings.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-park-link-v6.1-post.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-fix-setting-mac-address-for-netdev.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/wireless-uwe5622-Fix-compilation-with-6.7-kernel.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/wireless-uwe5622-reduce-system-load.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-fix-spanning-writes.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-fix-timer-api-changes-for-6.15-only-sunxi.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.17.patch"
    "${fetch.armbian}/patch/misc/wireless-uwe5622/uwe5622-v6.18.patch"
  ]
  ++ selectedPatches
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

  makeFlags = [
    "ARCH=arm64"
  ]
  ++ lib.optionals isCross [
    "CROSS_COMPILE=${stdenv.cc.targetPrefix}"
  ];

  prePatch = ''
    ${import ./wifi-patch.nix { uwe5622 = fetch.uwe5622; }}
  '';

  /*
    ${import ./dts.nix { armbian = fetch.armbian; }}

      #export LSMOD=$(mktemp)
      #cat "${modules}" | sort > $LSMOD
      #(yes "" | make LSMOD=$LSMOD localmodconfig) || true

      #make ARCH=arm64 $makeFlags olddefconfig
      #
      #
  */

  buildPhase = ''
    cp ${fetch.armbian}/config/kernel/linux-sunxi64-current.config .config
    chmod -R +w .config
    make $makeFlags olddefconfig
    patchShebangs scripts/config

    scripts/config ${lib.concatStringsSep " " config}

    make $makeFlags olddefconfig

    cat << 'EOF' >> .config
    CONFIG_UNISOC_WIFI_PS=y
    CONFIG_WLAN_UWE5622=m
    CONFIG_WLAN_UWE5621=m
    CONFIG_TTY_OVERY_SDIO=m
    CONFIG_AC200_PHY_SUNXI=m
    CONFIG_MFD_AC200_SUNXI=m
    EOF
  '';

  meta = pkgs.linuxPackages.kernel.passthru.configfile.meta // {
    platforms = [ "aarch64-linux" ];
  };

  passthru = {
    inherit localVer patches;
    version = kernelData.linux.version;
  };
}

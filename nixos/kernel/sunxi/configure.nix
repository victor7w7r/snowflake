{
  lib,
  pkgs,
  kernel,
  kernelData,
  ...
}:
let
  majorMinor = lib.versions.majorMinor kernelData.linux-legacy.version;
  fetch = (pkgs.callPackage ../fetch.nix { inherit kernelData majorMinor; });
  localVer = "-v7w7r-sunxi-hardened";
  config = (import ./config.nix);
  modules = ./modules.db;

  patchesRoute = "${fetch.armbian}/patch/kernel/archive/sunxi-6.12";
  patchLines = lib.splitString "\n" (builtins.readFile ./patches.config);
  patchesList = lib.filter (line: line != "" && !(lib.hasPrefix "#" line || lib.hasPrefix "-" line)) (
    map lib.strings.trim patchLines
  );
  selectedPatches = map (path: [ "${patchesRoute}/${path}" ]) patchesList;

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
    "${fetch.patches}/${majorMinor}/0002-bbr3.patch"
    "${fetch.patches}/${majorMinor}/0003-cachy.patch"
    "${fetch.patches}/${majorMinor}/0004-fixes.patch"
    "${fetch.patches}/${majorMinor}/0007-zstd.patch"
    "${fetch.linux-legacy-hardened}"
    #"${fetch.patches}/${majorMinor}/misc/reflex-governor.patch"
    #"${fetch.patches}/${majorMinor}/misc/nap-governor.patch"
  ];
in

pkgs.stdenv.mkDerivation {
  inherit patches;
  src = fetch.linux-legacy;
  name = "linux-${majorMinor}${localVer}-config";

  nativeBuildInputs =
    with pkgs;
    kernel.nativeBuildInputs
    ++ kernel.buildInputs
    ++ [
      ncurses
    ];
  installPhase = "cp .config $out";

  #${import ./dts.nix { armbian = fetch.armbian; }}
  prePatch = ''
    ${import ./wifi-patch.nix { uwe5622 = fetch.uwe5622; }}
  '';

  /*
    #export LSMOD=$(mktemp)
    #cat "${modules}" | sort > $LSMOD
    #(yes "" | make LSMOD=$LSMOD localmodconfig) || true

    #make ARCH=arm64 $makeFlags olddefconfig
  */

  buildPhase = ''
    cp ${fetch.armbian}/config/kernel/linux-sunxi64-legacy.config .config
    chmod -R +w .config
    patchShebangs scripts/config

    cat << 'EOF' >> .config
    CONFIG_UNISOC_WIFI_PS=y
    CONFIG_WLAN_UWE5622=m
    CONFIG_WLAN_UWE5621=m
    CONFIG_TTY_OVERY_SDIO=m
    CONFIG_AC200_PHY_SUNXI=m
    CONFIG_MFD_AC200_SUNXI=m
    EOF

    scripts/config ${lib.concatStringsSep " " config}
    make ARCH=arm64 $makeFlags olddefconfig

    ./scripts/config --enable CONFIG_DMIID
  '';

  meta = pkgs.linuxPackages.kernel.passthru.configfile.meta // {
    platforms = [ "aarch64-linux" ];
  };

  passthru = {
    inherit localVer patches;
    version = kernelData.linux.version;
  };
}

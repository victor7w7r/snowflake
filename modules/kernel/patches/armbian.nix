{ lib, ... }:
{
  kernel.patches.armbian =
    pkgs:
    let
      source =
        with (pkgs.lib.trivial.importJSON ./patches.json).armbian;
        pkgs.fetchFromGitHub {
          inherit
            repo
            rev
            owner
            hash
            ;
        };
      rockchip = pkgs.stdenvNoCC.mkDerivation {
        name = "rockchip-patches";
        src = source;
        phases = [
          "unpackPhase"
          "buildPhase"
          "installPhase"
        ];
        buildPhase = ''
          find $src/patch/kernel/archive/rockchip64-6.18 -maxdepth 1 -name '*.patch' -printf '%f\n' | sort > series.conf
          sed -i '/^rk3399-/d' series.conf
        '';
        installPhase = "cp series.conf $out";
      };
    in
    {
      inherit source;
      rockchip-patches =
        with lib;
        pipe rockchip [
          builtins.readFile
          (splitString "\n")
          (map strings.trim)
          (filter (line: line != "" && !(hasPrefix "#" line || hasPrefix "-" line)))
          (map (path: "${source}/patch/kernel/archive/rockchip64-6.18/${path}"))
        ];
      sunxi-patches =
        with lib;
        pipe "${source}/patch/kernel/archive/sunxi-6.18/series.conf" [
          builtins.readFile
          (splitString "\n")
          (map strings.trim)
          (filter (line: line != "" && !(hasPrefix "#" line || hasPrefix "-" line)))
          (map (path: "${source}/patch/kernel/archive/sunxi-6.18/${path}"))
        ];
    };
  /*
    [
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
  */
}

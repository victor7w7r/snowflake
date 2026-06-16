{ lib, ... }:
{
  kernel.patches.sunxi =
    pkgs:
    let
      patch = pkgs.lib.trivial.importJSON ./patches.json;
      armbian = pkgs.fetchFromGitHub {
        owner = patch.armbian.user;
        repo = patch.armbian.repo;
        rev = patch.armbian.rev;
        hash = patch.armbian.hash;
      };

      patchesRoute = "${armbian}/patch/kernel/archive/sunxi-6.18";
      patchLines = lib.splitString "\n" (
        builtins.readFile "${armbian}/patch/kernel/archive/sunxi-6.18/series.conf"
      );
      patchesList = lib.filter (line: line != "" && !(lib.hasPrefix "#" line || lib.hasPrefix "-" line)) (
        map lib.strings.trim patchLines
      );
      patches = map (path: "${patchesRoute}/${path}") patchesList;
    in
    {
      inherit patches armbian;
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

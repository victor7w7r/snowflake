{
  kernel.lib.sunxi-wifi =
    { pkgs }:
    let
      patch = pkgs.lib.trivial.importJSON ./patches.json;
      uwe5622 = pkgs.fetchFromGitHub {
        owner = patch.uwe5622.user;
        repo = patch.uwe5622.repo;
        rev = patch.uwe5622.rev;
        hash = patch.uwe5622.hash;
      };
    in
    ''
      mkdir -p drivers/net/wireless/uwe5622
      cp -r ${uwe5622}/Kconfig drivers/net/wireless/uwe5622/
      cp -r ${uwe5622}/Makefile drivers/net/wireless/uwe5622/
      cp -r ${uwe5622}/unisocwifi drivers/net/wireless/uwe5622/
      cp -r ${uwe5622}/unisocwcn drivers/net/wireless/uwe5622/
      cp -r ${uwe5622}/tty-sdio drivers/net/wireless/uwe5622/

      chmod -R +w drivers/net/wireless/uwe5622/

      echo "obj-\$(CONFIG_SPARD_WLAN_SUPPORT) += uwe5622/" >> "drivers/net/wireless/Makefile"
    '';
}

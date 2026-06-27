{
  kernel.patches.sunxi-wifi =
    pkgs:
    (
      with (pkgs.lib.trivial.importJSON ./patches.json).uwe5622;
      pkgs.fetchFromGitHub {
        inherit
          repo
          rev
          owner
          hash
          ;
      }
    )
    |> (uwe5622: ''
      mkdir -p drivers/net/wireless/uwe5622
      cp -r ${uwe5622}/Kconfig drivers/net/wireless/uwe5622/
      cp -r ${uwe5622}/Makefile drivers/net/wireless/uwe5622/
      cp -r ${uwe5622}/unisocwifi drivers/net/wireless/uwe5622/
      cp -r ${uwe5622}/unisocwcn drivers/net/wireless/uwe5622/
      cp -r ${uwe5622}/tty-sdio drivers/net/wireless/uwe5622/
      chmod -R +w drivers/net/wireless/uwe5622/
      echo "obj-\$(CONFIG_SPARD_WLAN_SUPPORT) += uwe5622/" >> "drivers/net/wireless/Makefile"
    '');
}

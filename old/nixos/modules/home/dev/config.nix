{ pkgs, ... }:
{
  programs = {
    gitui.enable = true;
    jq.enable = true;
    lazysql.enable = true;
    #meli.enable = true; BUILD
    mods.enable = true;
    #visidata.enable = true;
  };
}

{
  host,
  config,
  username,
  ...
}:
{
  home.file = {
    "repositories/nixstrap".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
  }
  // (
    if host == "v7w7r-macmini81" then
      {
        "shared".source = config.lib.file.mkOutOfStoreSymlink "/run/media/shared";
        "storage".source = config.lib.file.mkOutOfStoreSymlink "/nix/persist/storage";
      }
    else if host == "v7w7r-rc71l" then
      {
        "games".source = config.lib.file.mkOutOfStoreSymlink "/run/media/games";
      }
    else if host == "v7w7r-youyeetoox1" then
      {
        "shared".source = config.lib.file.mkOutOfStoreSymlink "/run/media/shared";
        "cloud".source = config.lib.file.mkOutOfStoreSymlink "/nix/persist/cloud";
        ".xinitrc".text = ''
          export XAUTHORITY=/home/${username}/.Xauthority
          export XDG_SESSION_TYPE=x11
          export DESKTOP_SESSION=xfce
          exec startxfce4
        '';
      }
    else
      { }
  );

}

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
  xdg = {
    configFile."mimeapps.list".force = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "zen-beta.desktop" ];
        "video/png" = [ "zen-beta.desktop" ];
        "video/jpg" = [ "zen-beta.desktop" ];
        "video/*" = [ "zen-beta.desktop" ];
        "x-scheme-handler/http" = [ "zen-beta.desktop" ];
        "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
        "x-scheme-handler/https" = [ "zen-beta.desktop" ];
        "text/plain" = [ "zed.desktop" ];
        "text/html" = [ "zed.desktop" ];
        "application/x-extension-htm" = [ "zed.desktop" ];
        "application/x-extension-html" = [ "zed.desktop" ];
        "application/x-extension-shtml" = [ "zed.desktop" ];
        "application/xhtml+xml" = [ "zed.desktop" ];
        "application/x-extension-xhtml" = [ "zed.desktop" ];
        "application/x-extension-xht" = [ "zed.desktop" ];
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      download = "${config.home.homeDirectory}/Descargas";
      documents = "${config.home.homeDirectory}/Documentos";
      pictures = "${config.home.homeDirectory}/Imágenes";
      projects = null;
      music = null;
      videos = null;
      templates = null;
      publicShare = null;
    };
  };
}

{ lib, ... }:
{
  den.aspects.gui.provides.xdg = {
    nixos =
      { pkgs, ... }:
      {
        environment.pathsToLink = lib.mkAfter [ "/share/xdg-desktop-portal" ];
        xdg = {
          mime.enable = true;
          autostart.enable = true;
          menus.enable = true;
          sounds.enable = true;
          icons.enable = true;
          terminal-exec.enable = true;
          portal = {
            enable = true;
            xdgOpenUsePortal = true;
            extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
          };
        };
      };

    homeManager =
      { config, ... }:
      {
        xdg = {
          configFile."mimeapps.list".force = true;
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
      };
  };
}

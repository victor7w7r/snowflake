{
  config,
  lib,
  hosts-attrs,
  ...
}:
{
  den.aspects.gui.provides =
    lib.genAttrs hosts-attrs.graphic (_: {
      nixos = {
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
          };
        };
      };

      homeManager = {
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
      };
    })
    // lib.genAttrs hosts-attrs.peripheralgui (_: {
      nixos =
        { pkgs, ... }:
        {
          xdg.portal.extraPortals = with pkgs; [ kdePackages.xdg-desktop-portal-kde ];
        };
    })
    // lib.genAttrs [ "server" ] (_: {
      nixos =
        { pkgs, ... }:
        {
          xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        };
    });
}

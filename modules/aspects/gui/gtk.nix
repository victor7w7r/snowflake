{ ... }:
{
  den.aspects.gui.provides.gtk.homeManager =
    { pkgs, ... }:
    {
      gtk = {
        #appmenu-gtk-module
        enable = true;
        font = {
          name = "JetBrainsMono Nerd Font";
          size = 11;
        };
        iconTheme = {
          name = "Colloid-Purple-Catppuccin-Dark";
          package = (
            pkgs.colloid-icon-theme.override {
              schemeVariants = [ "catppuccin" ];
              colorVariants = [ "purple" ];
            }
          );
        };
        theme = {
          name = "Layan-Dark";
          package = pkgs.layan-gtk-theme;
        };
        gtk3.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";
        gtk4.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";
      };

      home.packages = (
        with pkgs;
        [
          layan-gtk-theme
          #layan-kde
          #gtk-engines
          #https://github.com/debasish-patra-1987/linuxthemestore
          #gtk-engine-murrine
          #xdg-user-dirs-gtk
          (pkgs.colloid-icon-theme.override {
            schemeVariants = [ "catppuccin" ];
            colorVariants = [ "purple" ];
          })
          capitaine-cursors
          capitaine-cursors-themed

        ]
      );
      #programs.pywal.enable = true;
    };
}

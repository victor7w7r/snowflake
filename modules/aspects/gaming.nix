{ lib, ... }:
{

  flake-file.inputs.nix-gaming.url = "github:fufexan/nix-gaming";

  den.aspects.gui.provides = lib.genAttrs [ "handheld" ] (_: {
    nixos =
      { pkgs, ... }:
      {
        hardware.steam-hardware.enable = true;
        programs.steam = {
          enable = true;
          dedicatedServer.openFirewall = false;
          extraCompatPackages = with pkgs; [ proton-ge-bin ];
          extraPackages = with pkgs; [
            mangohud
            gamescope
          ];
          localNetworkGameTransfers.openFirewall = true;
          gamescopeSession.enable = true;
          protontricks.enable = true;
          remotePlay.openFirewall = true;
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        services.ludusavi.enable = true;
        programs = {
          gamemode.enable = true;
          mangohud.enable = true;
        };
        home.packages = with pkgs; [
          #bottles
          umu-launcher
          goverlay
          inotify-info
          #nyrna
          #xorg-xwininfo
          #xone-dongle-firmware
          prismlauncher
          protonup-qt
          vkd3d-proton
          vkbasalt
          winetricks
        ];
        /*
          wineWowPackages.staging
            wineWowPackages.waylandFull
            wineWowPackages.fonts
        */
      };
  });
}

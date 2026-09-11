{
  den.aspects.plasma.maliit = {
    nixos =
      { pkgs, ... }:
      {
        programs.dconf.enable = true;

        environment.systemPackages = with pkgs; [
          dconf-editor
          maliit-framework
          maliit-keyboard
        ];
      };

    provides.to-users.homeManager =
      { lib, pkgs, ... }:
      {
        programs.plasma.configFile.kwinrc.Wayland = {
          InputMethod = "${pkgs.maliit-keyboard}/share/applications/com.github.maliit.keyboard.desktop";
          VirtualKeyboardEnabled = true;
        };
        dconf.settings = {
          "org/maliit/keyboard/maliit" = {
            enabled-languages = lib.hm.gvariant.mkArray lib.hm.gvariant.type.string [
              "en"
              "es"
              "emoji"
            ];
            theme = "BreezeDark";
          };
        };
      };
  };
}

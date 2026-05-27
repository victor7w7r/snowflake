{
  inputs,
  lib,
  hosts-attrs,
  ...
}:
{

  flake-file.inputs.nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.7.0";

  den.aspects.gui.provides = lib.genAttrs hosts-attrs.softwaregui (_: {
    nixos =
      { user, ... }:
      {
        environment.persistence."/nix/persist".users."${user}".directories = [ ".config/flatpak" ];
        imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

        #https://github.com/MykolaSuprun/nixos-flakes-config/blob/c0b9e3356c8675cb50885a279b0978b99abdb705/nixos/modules/flatpak.nix
        services.flatpak = {
          enable = false;
          /*
            packages = [
              "io.github.DenysMb.Kontainer"
              "io.github.nyre221.kiview"
              "org.kde.kommit"
              "com.github.d4nj1.tlpui"
              "in.srev.guiscrcpy"
              "com.github.vikdevelop.photopea_app"
              "com.github.tchx84.Flatseal"
              "io.emeric.toolblex"
                KDiskFree
                OptiImage
            ];
          */
          /*
            update.auto = {
            enable = true;
            onCalendar = "weekly";
            };
          */
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ warehouse ];
      };
  });
}

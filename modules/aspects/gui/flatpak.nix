{ inputs, lib, ... }:
{
  flake-file.inputs.nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

  den.aspects.base.gui.flatpak = {
    nixos =
      {
        isVisual,
        isPersistent,
        user,
        ...
      }:
      lib.optional (isVisual && isPersistent) {
        environment.persistence."/nix/persist".users."${user}".directories = [ ".config/flatpak" ];
        programs.appimage = {
          enable = true;
          binfmt = true;
        };
      };

    homeManager =
      {
        isVisual,
        isPersistent,
        pkgs,
        ...
      }:
      lib.optional (isVisual && isPersistent) {
        imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
        #https://github.com/MykolaSuprun/nixos-flakes-config/blob/c0b9e3356c8675cb50885a279b0978b99abdb705/nixos/modules/flatpak.nix
        services.flatpak = {
          enable = true;
          update = {
            auto = {
              enable = true;
              onCalendar = "weekly";
            };
            onActivation = true;
          };
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
        };
        home.packages = with pkgs; [
          flatpak
          warehouse
        ];
      };
  };
}

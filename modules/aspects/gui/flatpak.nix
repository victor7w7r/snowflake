{ inputs, ... }:
{
  flake-file.inputs.nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

  den.aspects.gui.flatpak =
    { user, ... }:
    {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

      nixos.environment.persistence."/nix/persist".users."${user.name}".directories = [
        ".config/flatpak"
      ];

      programs.appimage = {
        enable = true;
        binfmt = true;
      };

      services.flatpak = {
        enable = true;
        update = {
          onActivation = true;
          auto = {
            enable = true;
            onCalendar = "weekly";
          };
        };
        remotes = [
          {
            name = "flathub";
            location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
          }
        ];
        packages =
          [
            "io.github.DenysMb.Kontainer"
            "org.kde.kommit"
            "com.github.d4nj1.tlpui"
            "com.github.tchx84.Flatseal"
            "io.emeric.toolblex"
            "org.kde.optiimage"
          ]
          |> map (id: {
            appId = id;
            origin = "flathub";
          });
      };
    };
}

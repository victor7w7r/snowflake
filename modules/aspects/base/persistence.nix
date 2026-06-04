{ lib, ... }:
{
  flake-file.inputs.impermanence.url = "github:nix-community/impermanence";

  den.aspects.base.persistence.nixos =
    {
      inputs',
      isPersistent,
      user,
      ...
    }:
    lib.optional isPersistent {
      imports = [ inputs'.impermanence.nixosModules.impermanence ];
      environment.persistence."/nix/persist" = {
        hideMounts = true;
        directories = [
          "/etc/nixos"
          "/var/log"
          "/var/lib/chrony"
          "/var/lib/fail2ban"
          "/var/lib/lastlog"
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/var/lib/tailscale"
        ];
        files = [
          "/etc/adjtime"
          "/etc/logo.svg"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_rsa_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/machine-id"
        ];
        users = {
          "${user}".directories = [
            "Documentos"
            "Descargas"
            "Imágenes"
            "repositories"
            "scripts"
            "remote"
            ".cache/thumbnails"
            ".local/share/cod"
            ".local/share/zoxide"
            ".local/share/nix"
            ".config/freerdp"
            ".config/Seafile"
            ".local/share/Trash"
            ".ssh"
            ".gnupg"
            ".ccnet"
          ];
          root.directories = [
            ".zsh"
            ".tmux"
            ".cache/antidote"
          ];
        };
      };
    };
}

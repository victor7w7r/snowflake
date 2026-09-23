{ inputs, ... }:
{
  flake-file.inputs.impermanence.url = "github:nix-community/impermanence";

  den.aspects.persistence = {
    nixos =
      {
        isPersistent,
        lib,
        user,
        ...
      }:
      {
        imports = [ inputs.impermanence.nixosModules.impermanence ];

        environment.persistence."/nix/persist" = lib.optionalAttrs isPersistent {
          hideMounts = true;
          directories = [
            "/etc/nixos"
            "/var/log"
            "/var/cache/ccache"
            "/var/cache/sccache"
            "/var/lib/chrony"
            "/var/lib/fail2ban"
            "/var/lib/lastlog"
            "/var/lib/nixos"
            "/var/lib/sbctl"
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
            "${user.name}" = {
              files = [
                ".zsh_history"
                ".bash_history"
              ];
              directories = [
                ".cache/antidote"
                ".cache/nvim"
                ".cache/thumbnails"
                ".ccnet"
                ".config/Seafile"
                ".config/freerdp"
                ".config/nix"
                ".gnupg"
                ".local/bin"
                ".local/share/Trash"
                ".local/share/atuin"
                ".local/share/cod"
                ".local/share/zoxide"
                ".local/share/nvim"
                ".local/state"
                ".ssh"
                ".zsh"
                ".tmux"
                "Descargas"
                "Documentos"
                "Imagenes"
                "remote"
                "repositories"
                "scripts"
              ];
            };
            root.directories = [
              ".zsh"
              ".cache/antidote"
            ];
          };
        };
      };

  };
}

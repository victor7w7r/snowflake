{
  den.aspects.kmscon.nixos =
    { pkgs, ... }:
    {
      services.kmscon = {
        enable = true;
        hwRender = false;
        fonts = [
          {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font Mono";
          }
        ];
        extraConfig = ''
          font-size=9
          sb-size=10000
          palette=custom
          palette-background=30, 30, 46
        '';
      };

      systemd.services = {
        "getty@tty7".enable = false;
        "autovt@tty7".enable = false;
        "kmsconvt@tty1".enable = false;
        "kmsconvt@tty7".enable = false;
        "getty@tty1".enable = false;
        "autovt@tty1".enable = false;
      };
    };
}

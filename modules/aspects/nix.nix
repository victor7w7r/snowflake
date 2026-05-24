{
  flake-file.nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-gaming.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.garnix.io"
      "https://cache.saumon.network/proxmox-nixos"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "proxmox-nixos:D9RYSWpQQC/msZUWphOY2I5RLH5Dd6yQcaHIuug7dWM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  den.aspects.nix = {
    nixos.nix = {
      settings = {
        max-jobs = "auto";
        max-substitution-jobs = 128;
        http-connections = 128;
        cores = 0;

        trusted-users = [
          "@wheel"
        ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      settings.auto-optimise-store = true;
    };

    homeManager =
      { pkgs, ... }:
      {
        programs.nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep 10 --keep-since 5d";
        };

        home.packages = with pkgs; [
          statix
          cachix
        ];
      };
  };
}

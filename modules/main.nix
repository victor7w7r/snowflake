{ den, lib, ... }:
let
  settings = {
    always-allow-substitutes = true;
    allow-import-from-derivation = true;
    accept-flake-config = true;
    auto-optimise-store = true;
    use-xdg-base-directories = true;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://cache.garnix.io"
      "https://cache.numtide.com"
      "https://cache.saumon.network/proxmox-nixos"
      "https://nix-gaming.cachix.org"
      "https://attic.xuyh0120.win/lantian"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "proxmox-nixos:D9RYSWpQQC/msZUWphOY2I5RLH5Dd6yQcaHIuug7dWM="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];

    trusted-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://cache.numtide.com"
      "https://attic.xuyh0120.win/lantian"
    ];

    extra-substituters = [ "https://cache.numtide.com" ];

    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "cache.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };
in
{
  flake-file.nixConfig = settings // {
    lazy-trees = true;
    submodules = true;
  };

  _module.args.__findFile = den.lib.__findFile;

  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.inputs'
      den.batteries.self'
    ];
    darwin = {
      system.stateVersion = 6;
      nix.settings = settings;
    };
    nixos = {
      system.stateVersion = "26.05";
      documentation.enable = lib.mkDefault false;
      nixpkgs.config.allowUnfree = true;
      programs.nix-ld.enable = true;
      #package = lib.mkDefault (pkgs.lix);

      nix.settings = {
        narinfo-cache-negative-ttl = 0;
        max-substitution-jobs = 128;
        keep-build-log = lib.mkDefault false;
        http-connections = 128;
        keep-derivations = lib.mkDefault false;
        max-jobs = "auto";
        cores = 0;

        trusted-users = [
          "root"
          "@wheel"
        ];
      }
      // settings;
    };
  };
}

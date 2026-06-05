{ inputs, ... }:
{
  imports = [ (inputs.den.namespace "settings" false) ];

  settings.lib.settings = {
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

}

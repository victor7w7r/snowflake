{
  flake-file.inputs = {
    thorium.url = "github:almahdi/nix-thorium";
    hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/0.1";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };
}

{ inputs, ... }:
{
  flake-file.inputs.agenix.url = "github:ryantm/agenix";
  den.aspects.secrets.imports = [ inputs.agenix.nixosModules.default ];
  nixos.nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
}

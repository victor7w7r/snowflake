{ inputs, ... }:
{
  flake-file.inputs.disko.url = "github:nix-community/disko";
  imports = [ (inputs.den.namespace "disko" false) ];
}

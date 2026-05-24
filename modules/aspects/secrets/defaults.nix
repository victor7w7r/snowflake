{ inputs, ... }:
{
  flake-file.inputs.agenix.url = "github:ryantm/agenix";
  den.aspects.secrets = {
    imports = [ inputs.agenix.nixosModules.default ];
  };
}

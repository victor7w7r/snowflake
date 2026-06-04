{
  flake-file.inputs.agenix.url = "github:ryantm/agenix";
  den.aspects.secrets.nixos =
    { inputs', ... }:
    {
      imports = [ inputs'.agenix.nixosModules.default ];
    };
}

{
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.treefmt.withConfig {
        runtimeInputs = with pkgs; [
          nixfmt
          deadnix
        ];
        settings = {
          on-unmatched = "info";
          formatter = {
            nixfmt = {
              command = "nixfmt";
              includes = [ "*.nix" ];
            };
            deadnix = {
              command = "deadnix";
              options = [
                "--edit"
                "--no-lambda-arg"
                "--no-lambda-pattern-names"
              ];
              includes = [ "*.nix" ];
            };
          };
        };
      };
    };
}

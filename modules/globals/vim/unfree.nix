{
  den.default.os = { lib, ... }: {
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "tree-sitter-http"
      ];
  };
}

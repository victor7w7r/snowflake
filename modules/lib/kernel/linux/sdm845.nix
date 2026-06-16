{
  kernel.linux.sdm845 =
    { pkgs }:
    let
      source = pkgs.lib.trivial.importJSON ./packages.json;
    in
    {
      sdm845 = pkgs.fetchFromGitea {
        domain = source.sdm845.domain;
        owner = source.sdm845.owner;
        repo = source.sdm845.repo;
        rev = source.sdm845.rev;
        hash = source.sdm845.hash;
      };
    };
}

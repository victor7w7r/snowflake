{
  kernel.linux.sdm845 =
    pkgs:
    with (pkgs.lib.trivial.importJSON ./packages.json).sdm845;
    pkgs.fetchFromGitea {
      inherit
        domain
        owner
        repo
        rev
        hash
        ;
    };
}

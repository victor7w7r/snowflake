{
  kernel.patches.bunker =
    pkgs:
    let
      patch = pkgs.lib.trivial.importJSON ./patches.json;
      bunker = pkgs.fetchFromGitHub {
        owner = patch.bunker.user;
        repo = patch.bunker.repo;
        rev = patch.bunker.rev;
        hash = patch.bunker.hash;
      };
    in
    {

    };
}

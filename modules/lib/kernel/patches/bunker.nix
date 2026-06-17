{
  kernel.patches.bunker =
    pkgs:
    let
      patches =
        with (pkgs.lib.trivial.importJSON ./patches.json).bunker;
        pkgs.fetchFromGitHub {
          inherit
            repo
            rev
            owner
            sha256
            ;
        };
    in
    {

    };
}

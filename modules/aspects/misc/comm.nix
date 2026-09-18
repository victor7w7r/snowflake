{
  den.aspects.misc.comm.nixos =
    { pkgs, self', ... }:
    {
      environment.systemPackages =
        with pkgs;
        with self'.packages;
        [
          carbonyl
          mabel
          discordo
          nchat
          reader
          stig
          #tewi
        ];
    };
}

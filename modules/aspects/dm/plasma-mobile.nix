{ den, ... }: {
  den.aspects.plasma-mobile = {

    includes = with den.aspects; [
      plasma.sddm
    ];

    nixos =
      { pkgs, ... }:
      {
        services.xserver.enable = true;

        environment.systemPackages = with pkgs.kdePackages; [
          plasma-mobile
          plasma-nano
          plasma-dialer
          spacebar
          pkgs.maliit-framework
          pkgs.maliit-keyboard
        ];
      };
  };
}

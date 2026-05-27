{
  den.aspects.nix.provides.settings.nixos.nix = {
    settings = {
      auto-optimise-store = true;
      max-jobs = "auto";
      max-substitution-jobs = 128;
      http-connections = 128;
      cores = 0;
      trusted-users = [ "@wheel" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}

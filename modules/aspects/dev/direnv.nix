{
  den.aspects.dev.provides.git.nixos.programs.direnv = {
    enable = false;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

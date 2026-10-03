{
  den.aspects.containers = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          arion
          ctop
          container2wasm
          devbox
          distrobox
          dockmate
          distrobox-tui
          dive
          fuse-overlayfs
          gomanagedocker
          kompose
          oxker
          pods
          podman-tui
          #self'.packages.dockerfilegraph
          #self'.packages.dprs
          #self'.packages.supdock
          #self'.packages.runlike
        ];
      };
    provides.to-users.homeManager.programs.lazydocker.enable = true;
  };
}

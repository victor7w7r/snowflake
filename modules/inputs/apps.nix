{
  flake-file.inputs = {
    thorium.url = "github:almahdi/nix-thorium";
    xrlinux = {
      url = "github:wheaney/XRLinuxDriver";
      flake = false;
    };
  };
}

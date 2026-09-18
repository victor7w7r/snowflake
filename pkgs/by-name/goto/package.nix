{ buildGoModule, inputs }:
buildGoModule {
  pname = "goto";
  version = "latest";
  src = inputs.goto;
  vendorHash = "sha256-nSpxZRVi9MLp15hx8ig29SsJ+ahXt8iYiGkFXHLK43w=";
  preBuild = ''export GOCACHE="/var/cache/gocache"'';
  doCheck = false;
  ldflags = [
    "-s"
    "-w"
  ];
  flags = [ "-trimpath" ];
}

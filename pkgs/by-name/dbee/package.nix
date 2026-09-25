{ buildGoModule, inputs }:
buildGoModule {
  pname = "dbee";
  version = "latest";
  src = inputs.dbee;
  vendorHash = "sha256-mx6ymmo9+behRSSUfm3NiDY7utyM/ACV5XPaiph39w8=";
  preBuild = ''export GOCACHE="/var/cache/gocache"'';
  doCheck = false;
  ldflags = [
    "-s"
    "-w"
  ];
  flags = [ "-trimpath" ];
}

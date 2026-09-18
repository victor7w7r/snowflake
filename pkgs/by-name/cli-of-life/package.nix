{ buildGoModule, inputs }:
buildGoModule {
  pname = "cli-of-life";
  version = "latest";
  src = inputs.cli-of-life;
  vendorHash = "sha256-KCKgJxko94BIA6rYLJrCDhlucYtoqTPYY4gZLqeenIw=";
  preBuild = ''export GOCACHE="/var/cache/gocache"'';
  doCheck = false;
  ldflags = [
    "-s"
    "-w"
  ];
  flags = [ "-trimpath" ];

}

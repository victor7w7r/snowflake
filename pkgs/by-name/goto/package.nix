{ buildGoModule, inputs }:
buildGoModule {
  pname = "goto";
  version = "latest";
  src = inputs.goto;
  vendorHash = "sha256-LfC/p1mIG1/PZwaoPBI6Ii/A895s2EzhIwMSdukem44=";
  preBuild = ''export GOCACHE="/var/cache/gocache"'';
  doCheck = false;
  ldflags = [
    "-s"
    "-w"
  ];
  flags = [ "-trimpath" ];
}

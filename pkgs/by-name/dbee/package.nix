{ inputs, pkgs }:
pkgs.buildGoModule {
  pname = "dbee";
  version = "latest";
  src = "${inputs.dbee}/dbee";
  vendorHash = "sha256-ah3gpaL1XSlktQNCE8sHNLJtKY5zBNNNDetinq/zySM=";
  preBuild = ''export GOCACHE="/var/cache/gocache"'';
  modDir = "dbee";
  doCheck = false;

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [
    arrow-cpp
    duckdb
  ];
  tags = [ "duckdb_use_lib" ];

  ldflags = [
    "-s"
    "-w"
  ];
  flags = [ "-trimpath" ];
}

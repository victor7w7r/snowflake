{ pkgs, nimPackages }:
nimPackages.buildNimPackage (attrs: {
  pname = "bestfetch";
  version = "main";

  src = pkgs.fetchFromGitLab {
    owner = "Maxb0tbeep";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=";
  };

  nativeBuildInputs = with pkgs; [ git ];
  nimFlags = [ "-d:release" ];
  nimbleBuildTarget = "build/${attrs.pname}";
})

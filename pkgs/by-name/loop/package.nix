{
  rustBuild,
  inputs,
  pkgs,
}:
(rustBuild {
  inherit pkgs;
  pname = "loop";
  cargoHash = "sha256-HN6vcMjUaNU3rt/2fWLEF4eF0vOW76KPIIa2HtbiaZg=";
  src = pkgs.runCommand "loop-src-with-lock" { } ''
    mkdir -p $out
    cp -r --no-target-directory ${inputs.loop} $out
    chmod -R +w $out
    cp ${./Cargo.lock} $out/Cargo.lock
  '';
})

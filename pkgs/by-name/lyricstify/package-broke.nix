{
  fetchFromGitHub,
  buildNpmPackage,
  nodejs_22,
}:

buildNpmPackage rec {
  pname = "lyricstify";
  version = "main";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = version;
    hash = "sha256-jwCgL2DiHhgbGTk1HOJzIGOBW/P03rA9J3BMX2xNVW0=";
  };

  npmFlags = [ "--legacy-peer-deps" ];
  npmInstallFlags = [ "--legacy-peer-deps" ];

  makeCacheWritable = true;
  ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";

  npmDepsHash = "sha256-+ZrlkuEasg6GjR0CUG/7neNOyp4tNKPHdMK/yrvA8B0=";

  nodejs = nodejs_22;

  installPhase = ''
    mkdir -p $out/lib/node_modules/lyricstify
    mkdir -p $out/bin

    cp -r . $out/lib/node_modules/lyricstify/
    chmod +x $out/lib/node_modules/lyricstify/dist/cli.js

    cat << EOF > $out/bin/lyricstify
    #!/bin/sh
    exec ${nodejs}/bin/node $out/lib/node_modules/lyricstify/dist/cli.js "\$@"
    EOF

    chmod +x $out/bin/lyricstify
  '';
}

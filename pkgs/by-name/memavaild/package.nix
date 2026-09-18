{ inputs, pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "memavaild";
  version = "latest";

  src = inputs.memavaild;

  nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
  buildInputs = [ pkgs.python3 ];

  installPhase = ''
    mkdir -p $out/bin $out/lib/systemd/system $out/etc

    make base units \
      DESTDIR=$out \
      PREFIX= \
      SYSCONFDIR=/etc \
      SYSTEMDUNITDIR=/lib/systemd/system

    substituteInPlace $out/lib/systemd/system/memavaild.service \
      --replace-fail "/usr/local/bin/memavaild" "$out/bin/memavaild"

    wrapProgram $out/bin/memavaild \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.python3 ]}
  '';
}

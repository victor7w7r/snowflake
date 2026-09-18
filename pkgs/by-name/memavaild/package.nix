{ inputs, pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "memavaild";
  version = "latest";

  src = inputs.memavaild;

  nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
  buildInputs = [ pkgs.python3 ];

  installPhase = ''
    mkdir -p $out/sbin $out/lib/systemd/system $out/etc

    make base units \
      DESTDIR=$out \
      PREFIX= \
      SYSCONFDIR=/etc \
      SYSTEMDUNITDIR=/lib/systemd/system

    substituteInPlace $out/lib/systemd/system/memavaild.service \
      --replace-fail "/sbin/memavaild" "$out/sbin/memavaild"

    wrapProgram $out/sbin/memavaild \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.python3 ]}
  '';
}

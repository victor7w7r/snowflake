{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation (attrs: {
  pname = "shutter-encoder";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "paulpacifico";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-5xkKNgwzIAAAdqk2z/HiCtXNm/ZyjXflSJcT1dAn6nU=";
  };

  nativeBuildInputs = with pkgs; [
    jdk25
    makeWrapper
  ];

  buildInputs = with pkgs; [ alsa-lib ];

  preBuild = ''
    mkdir -p Library
    # cp ''${tercer_jar} Library/dependencia.jar

    jlink \
      --strip-debug \
      --no-header-files \
      --no-man-pages \
      --add-modules java.base,java.datatransfer,java.desktop,java.logging,java.security.sasl,java.xml,jdk.crypto.ec \
      --output JRE
  '';

  buildPhase = ''
    runHook preBuild

    # Ejemplo si se compila con el comando javac básico o si ya trae un build script:
    # javac -d bin -cp "Library/*" src/**/*.java
    # jar cvfm $pname.jar manifest.mf -C bin .

    runHook postBuild
  '';

  installPhase = ''
    mkdir -p "$out/share/$pname"
    mkdir -p "$out/bin"

    cp -r JRE "$out/share/$pname/"
    cp -r Library "$out/share/$pname/"

    makeWrapper "$out/share/$pname/JRE/bin/java" "$out/bin/$pname" \
      --add-flags "-jar $out/share/$pname/$pname.jar" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ pkgs.alsa-lib ]}"
  '';
})

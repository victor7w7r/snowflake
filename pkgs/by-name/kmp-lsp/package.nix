{
  rustBuild,
  inputs,
  pkgs,
}:
let
  sidecarPlatform =
    if pkgs.stdenv.hostPlatform.isDarwin then
      if pkgs.stdenv.hostPlatform.isAarch64 then "darwin-aarch64" else "darwin-x86_64"
    else if pkgs.stdenv.hostPlatform.isAarch64 then
      "linux-aarch64"
    else
      "linux-x86_64";
  sidecarHash =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "sha256-vYF/dJdl5vt6DBOuK1Zb80sUL0deA4QKS3ibA7GoTXk="
    else if pkgs.stdenv.hostPlatform.isAarch64 then
      "sha256-ylaiv5ynLeuUc2QMNdPSrF3coxTtxXPnt9KFDcmSuKQ="
    else
      "sha256-/BjozCMpnvE7CJG/9biFXcLmZipv+Q8O7MgkZ/rzWQs=";
  sidecar = pkgs.fetchurl {
    url = "https://github.com/Hessesian/kmp-lsp/releases/download/v0.27.0/kmp-jar-indexer-${sidecarPlatform}.gz";
    hash = sidecarHash;
  };
  jemallocPrefixed = pkgs.jemalloc.overrideAttrs (old: {
    configureFlags = (old.configureFlags or [ ]) ++ [ "--with-jemalloc-prefix=_rjem_" ];
  });
  jemallocLib = "${jemallocPrefixed}/lib/libjemalloc${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
in
(rustBuild {
  inherit pkgs;
  cargoHash = "sha256-GGkb8KWc2ZicSOKMErS+a97PT983weioDyE79HRxa4I=";
  pname = "kmp-lsp";
  src = inputs.kmp-lsp;

  nativeBuildInputs =
    with pkgs;
    [
      pkg-config
      gzip
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [ autoPatchelfHook ];

  buildInputs =
    with pkgs;
    [
      zstd
      zlib
      jemalloc
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [ stdenv.cc.cc.lib ];

  postPatch = ''
    if [ -f .cargo/config.toml ]; then
      substituteInPlace .cargo/config.toml \
        --replace-quiet "nixpkgs.1pVv/use/system/library/lib/libjemalloc" "${jemallocLib}"
    fi
  '';

  JEMALLOC_OVERRIDE = jemallocLib;

  postInstall = ''
    gunzip -c ${sidecar} > $out/bin/kmp-jar-indexer
    chmod +x $out/bin/kmp-jar-indexer
  '';
})

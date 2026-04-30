{
  postBuildCommands,
  bootSize,
  persistSize,
  persistLabel,
  storeLabel,
  isHDD,
  populateFirmwareCommands,
  closureInfo,
  imageName,
  pkgs,
  stdenv,
  libfaketime,
  fakeroot,
  util-linux,
  f2fs-tools,
  zstd,
  ...
}:
let
  store = import ./store.nix { inherit storeLabel isHDD closureInfo; };
  boot = import ./boot.nix { inherit bootSize persistSize populateFirmwareCommands; };
  persist = import ./persist.nix { inherit persistSize persistLabel; };
  #nativePkgs = import pkgs.path { system = pkgs.system; };
in
stdenv.mkDerivation {
  name = imageName;
  nativeBuildInputs = with pkgs; [
    bcachefs-tools
    dosfstools
    fakeroot
    f2fs-tools
    libfaketime
    mtools
    systemdUkify
    util-linux
    xfsprogs
    zstd
  ];

  buildCommand = ''
    mkdir -p $out

    ${persist}
    ${boot}
    dd conv=notrunc if=./persist.img of=boot.img seek=$START count=$SECTORS

    echo "Copying uboot and compressing boot image..."
    ${postBuildCommands}
    zstd -T$NIX_BUILD_CORES --rm boot.img && cp -a ./boot.img.zst $out/

    ${store}
  '';
}

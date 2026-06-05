{ inputs, sdcard, ... }:
{
  imports = [ (inputs.den.namespace "sdcard" false) ];

  sdcard.lib.call =
    {
      bootSize ? 96,
      isHDD ? true,
      persistSize ? 1024,
      persistLabel ? "persist",
      populateFirmwareCommands ? "",
      postBuildCommands ? "",
      storeLabel ? "store",
    }:
    {

      nixos =
        {
          config,
          host,
          pkgs,
          ...
        }:
        {
          system.nixos.tags = [ "sd-card" ];
          system.build.image = config.system.build.sdImage;
          system.build.sdImage = pkgs.stdenv.mkDerivation {
            name = "nixos-image-${config.system.nixos.label}-" + "${host}-${pkgs.stdenv.hostPlatform.system}";
            nativeBuildInputs = with pkgs; [
              bcachefs-tools
              dosfstools
              fakeroot
              f2fs-tools
              libfaketime
              mtools
              util-linux
              xfsprogs
              zstd
            ];

            buildCommand =
              let
                closureInfo = pkgs.buildPackages.closureInfo {
                  rootPaths = [ config.system.build.toplevel ];
                };
              in
              ''
                mkdir -p $out

                ${(sdcard.lib.persist { inherit persistSize persistLabel; })}
                ${(sdcard.lib.boot { inherit bootSize persistSize populateFirmwareCommands; })}
                dd conv=notrunc if=./persist.img of=boot.img seek=$START count=$SECTORS

                echo "Copying uboot and compressing boot image..."
                ${postBuildCommands}
                zstd -T$NIX_BUILD_CORES --rm boot.img && cp -a ./boot.img.zst $out/

                ${(sdcard.lib.store { inherit storeLabel isHDD closureInfo; })}
              '';
          };
        };
    };
}

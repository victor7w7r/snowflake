{ disko, lib, ... }:
{
  disko.f2fs = {
    call =
      {
        name ? "",
        priority ? 0,
        mountpoint,
        entireDisk ? false,
        hasDefSectorSize ? false,
        highEnd ? true,
        size ? null,
      }:
      (disko.f2fs.args {
        inherit name hasDefSectorSize highEnd;
      })
      |> (args: {
        inherit mountpoint;
        type = "filesystem";
        format = "f2fs";
        mountOptions = args.mountOptions;
        extraArgs = args.extraArgs;
      })
      |> (
        content:
        if (!entireDisk) then
          {
            inherit
              name
              size
              priority
              content
              ;
            type = "8300";
          }
        else
          content
      );

    args = {
      name ? "",
      hasDefSectorSize ? false,
      hasEncrypt ? false,
      highEnd ? true
    }: {
      mountOptions = [
        "lazytime"
        "noatime"
        "inline_xattr"
        "inline_data"
        "inline_dentry"
        "errors=remount-ro"
        "flush_merge"
        "checkpoint_merge"
        "gc_merge"
      ] ++ (lib.optionals highEnd [
        "atgc"
        "age_extent_cache"
        "compress_chksum"
        "compress_algorithm=zstd"
        "compress_extension=bin"
        "compress_extension=so"
      ]);
      extraArgs = [
        "-f"
        "-O"
        (lib.concatStringsSep "," (
            [
              "extra_attr"
              "inode_checksum"
              "flexible_inline_xattr"
              "lost_found"
              "sb_checksum"
            ]
            ++ (lib.optional highEnd "compression")
            ++ (lib.optional hasEncrypt "encrypt")
          ))
        "-l"
        name
      ]
      ++ (lib.optionals hasDefSectorSize [
        "-S"
        "4096"
      ]);
    };
  };
}

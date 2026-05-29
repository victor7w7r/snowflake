{ lib, ... }:
{
  den.aspects.f2fs =
    { config, ... }:
    {
      imports = [
        {
          options = {
            call = lib.mkOption { type = with lib.types; functionTo attrs; };
            args = lib.mkOption { type = with lib.types; functionTo attrs; };
          };
        }
      ];

      call =
        {
          name,
          priority,
          size ? null,
          mountpoint ? "/",
        }:
        let
          args = (import ./f2fs-args.nix) { inherit name; };
          mountOptions = args.mountOptions;
          extraArgs = args.extraArgs;
        in
        {
          inherit name size priority;
          type = "8300";
          content = {
            type = "filesystem";
            format = "f2fs";
            inherit
              mountpoint
              mountOptions
              extraArgs
              ;
          };
        };

      args =
        { name }:
        {
          mountOptions = [
            "lazytime"
            "noatime"
            "compress_chksum"
            "compress_algorithm=zstd"
            "age_extent_cache"
            "compress_extension=so"
            "inline_xattr"
            "inline_data"
            "inline_dentry"
            "errors=remount-ro"
            "compress_extension=bin"
            "atgc"
            "flush_merge"
            "discard"
            "checkpoint_merge"
            "gc_merge"
          ];
          extraArgs = [
            "-f"
            "-O"
            "extra_attr,inode_checksum,compression,flexible_inline_xattr,lost_found,sb_checksum"
            "-l"
            name
          ];
        };
    };
}

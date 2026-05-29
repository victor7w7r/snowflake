{ lib, ... }:
{
  den.aspects.btrfs =
    { config, ... }:
    rec {
      imports = [ { options.call = lib.mkOption { type = with lib.types; functionTo attrs; }; } ];

      emergency =
        {
          size ? "3G",
          name ? "emergency",
          mountpoint ? "/boot/emergency",
          isSolid ? true,
          priority ? 2,
        }:
        call {
          inherit
            name
            size
            priority
            mountpoint
            ;
          singleOptions = [
            "lazytime"
            "noatime"
            "compress=zstd:2"
          ]
          ++ (if isSolid then [ "discard=async" ] else [ "autodefrag" ]);
        };

      shared =
        {
          name ? "shared",
          size ? "100%",
          priority ? 100,
          isSolid ? true,
          mountContent ? "shared",
          mountSnap ? "sharedsnaps",
        }:
        call {
          inherit
            name
            size
            priority
            ;
          singleOptions = [
            "lazytime"
            "noatime"
            "compress-force=lzo"
          ]
          ++ (if isSolid then [ "discard=async" ] else [ "autodefrag" ]);

          volumes = {
            "/${mountContent}".mountpoint = "/run/media/${mountContent}";
            "/.${mountSnap}".mountpoint = "/run/media/.${mountSnap}";
          };
        };

      call =
        {
          name,
          priority ? 3,
          size ? "100%",
          mountpoint ? null,
          singleOptions ? [ ],
          extraOptions ? [ ],
          volumes ? { },
          isRoot ? false,
          isLzo ? false,
        }:
        let
          mountOptions = [
            "lazytime"
            "noatime"
            "discard=async"
            "compress=zstd:1"
          ]
          ++ extraOptions
          ++ (if isLzo then [ "compress=lzo" ] else [ "compress=zstd:1" ]);

          subvolumes =
            if isRoot then
              {
                "@" = {
                  mountpoint = "/";
                  inherit mountOptions;
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = mountOptions ++ [ "noacl" ];
                };
                "@persist" = {
                  mountpoint = "/nix/persist";
                  inherit mountOptions;
                };
              }
            else
              volumes;
        in
        {
          inherit name size priority;
          type = "8300";
          content = {
            inherit mountpoint subvolumes;
            mountOptions = singleOptions;
            type = "btrfs";
            extraArgs = [
              "-f"
              "-L"
              "${name}"
            ];
          };
        };
    };
}

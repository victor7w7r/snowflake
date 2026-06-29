{ disko, ... }:
{
  disko.btrfs = {
    emergency =
      {
        size ? "3G",
        name ? "emergency",
        mountpoint ? "/boot/emergency",
        isSolid ? true,
        priority ? 2,
      }:
      disko.btrfs.call {
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
      disko.btrfs.call {
        inherit
          name
          size
          priority
          ;
        singleOptions = [
          "lazytime"
          "noatime"
          "nofail"
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
      (
        [
          "lazytime"
          "noatime"
          "discard=async"
          "compress=${if isLzo then "lzo" else "zstd:1"}"
        ]
        ++ extraOptions
      )
      |> (mountOptions: {
        inherit name size priority;
        type = "8300";
        content = {
          inherit mountpoint;
          mountOptions = singleOptions;
          type = "btrfs";
          extraArgs = [
            "-f"
            "-L"
            "${name}"
          ];
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
        };
      });
  };
}

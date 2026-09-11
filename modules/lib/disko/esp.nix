{ lib, ... }: {
  disko.esp.call =
    {
      name ? "EFI",
      size ? "300M",
      mountpoint ? "/boot",
      hasDefSectorSize ? false,
      entireDisk ? false,
    }:
    {
      inherit mountpoint;
      type = "filesystem";
      format = "vfat";
      extraArgs = [
        "-F32"
        "-n"
        "EFI"
      ]
      ++ (lib.optionals hasDefSectorSize [
        "-S"
        "4096"
      ]);
      mountOptions = [
        "lazytime"
        "noatime"
        "nofail"
        "discard"
        "umask=0077"
        "dmask=0077"
        "codepage=437"
        "iocharset=ascii"
        "shortname=mixed"
      ];
    }
    |> (
      content:
      if (!entireDisk) then
        {
          inherit size name content;
          type = "EF00";
          priority = 1;
        }
      else
        content
    );
}

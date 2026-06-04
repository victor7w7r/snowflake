{ inputs, __findFile, ... }:
{
  #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.toplevel"
  #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.sdImage"
  #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.tarball"
  #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.bootFiles"
  #dd if=u-boot-sunxi-with-spl.bin of=/dev/sde bs=1024 seek=8 conv=notrunc
  #mount /dev/sde1 /mnt && rm -rf /mnt/* && tar --zstd -xvf boot.tar.zst -C /mnt/ --no-same-owner && umount /dev/sde1 && udisksctl power-off -b /dev/sde
  #mount -o noatime,nodiratime,lazytime,logbufs=8,logbsize=256k /dev/sde1 /mnt && rm -rf /mnt/* && tar --zstd -xvf store.tar.zst -C /mnt/ && sync && umount /dev/sde1 && udisksctl power-off -b /dev/sde

  imports = [ (inputs.den.namespace "pizero" false) ];

  den = {
    hosts.aarch64-linux.pizero = {
      hostName = "v7w7r-opizero2w";
      users.victor7w7r = { };
    };

    aspects.phone = {
      includes = [ ];

      nixos = {
      };
    };
  };
}

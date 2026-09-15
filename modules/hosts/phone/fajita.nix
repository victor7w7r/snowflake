{
  den,
  inputs,
  tarball,
  ...
}:
{

  #mount /dev/sdj13 /mnt && rm -rf /mnt/* && tar --zstd -xvf boot-fajita.tar.zst -C /mnt/ --no-same-owner && sync && umount /dev/sdj13
  #mount -o lazytime,noatime,inline_xattr,inline_data,inline_dentry,flush_merge,checkpoint_merge,gc_merge,atgc,age_extent_cache,compress_chksum,compress_algorithm=zstd,compress_extension=bin,compress_extension=so /dev/sdj17 /mnt && rm -rf /mnt/store/* && tar --zstd -xvf store-fajita.tar.zst -C /mnt/store/ && sync && umount /dev/sdj17

  perSystem.packages = {
    phone-fajita-toplevel = inputs.self.nixosConfigurations.phone-fajita.config.system.build.toplevel;

    phone-fajita-script =
      inputs.self.nixosConfigurations.phone-fajita.config.system.build.diskoImagesScript;

    phone-fajita-mktarball =
      inputs.self.nixosConfigurations.phone-fajita-tarball.config.system.build.tarball;
  };

  den = {
    hosts.aarch64-linux = {
      phone-fajita.users = {
        #root = { };
        victor7w7r = { };
      };
      phone-fajita-tarball.users = {
        #root = { };
        victor7w7r = { };
      };
    };
    aspects = {
      phone-fajita-tarball.includes = with den.aspects; [
        phone.common
        (tarball.lib.call {
          enableGenericExtlinux = false;
          dtbpath = "qcom/sdm845-oneplus-fajita.dtb";
        })
      ];

      phone-fajita = {
        includes = with den.aspects; [ phone.common ];
        nixos = {
          networking.hostName = "v7w7r-fajita";
          hardware.deviceTree.name = "qcom/sdm845-oneplus-fajita.dtb";
        };
      };
    };
  };
}

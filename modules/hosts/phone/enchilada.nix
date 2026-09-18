{
  den,
  inputs,
  tarball,
  ...
}:
{

  #mount /dev/sdi13 /mnt && rm -rf /mnt/* && tar --zstd -xvf boot-enchilada.tar.zst -C /mnt/ --no-same-owner && sync && umount /dev/sdi13
  #mount -o lazytime,noatime,inline_xattr,inline_data,inline_dentry,flush_merge,checkpoint_merge,gc_merge,atgc,age_extent_cache,compress_chksum,compress_algorithm=zstd,compress_extension=bin,compress_extension=so /dev/sdi17 /mnt && rm -rf /mnt/store/* && tar --zstd -xvf store-enchilada.tar.zst -C /mnt/store/

  perSystem.packages = {
    phone-enchilada-toplevel =
      inputs.self.nixosConfigurations.phone-enchilada.config.system.build.toplevel;
    phone-enchilada-script =
      inputs.self.nixosConfigurations.phone-enchilada.config.system.build.diskoImagesScript;
    phone-enchilada-mktarball =
      inputs.self.nixosConfigurations.phone-enchilada-tarball.config.system.build.tarball;
  };

  den = {
    hosts.aarch64-linux = {
      phone-enchilada.users = {
        #root = { };
        victor7w7r = { };
      };
      phone-enchilada-tarball.users = {
        #root = { };
        victor7w7r = { };
      };
    };
    aspects = {
      phone-enchilada-tarball.includes = with den.aspects; [
        phone.common
        (tarball.lib.call {
          enableGenericExtlinux = false;
          dtbpath = "qcom/sdm845-oneplus-enchilada.dtb";
        })
      ];

      phone-enchilada = {
        includes = with den.aspects; [ phone.common ];

        nixos = { lib, ... }: {
          networking.hostName = "v7w7r-enchilada";
          hardware.deviceTree.name = "qcom/sdm845-oneplus-enchilada.dtb";

          boot.initrd.kernelModules = lib.mkBefore [
            "bq27xxx_battery"
            "bq27xxx_battery_i2c"
            "qcom_spmi_rradc"
            "qcom_smbx"
          ];
        };
      };
    };
  };
}

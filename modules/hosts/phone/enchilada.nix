{ den, inputs, ... }:
{
  perSystem.packages = {
    phone-enchilada-toplevel =
      inputs.self.nixosConfigurations.phone-enchilada.config.system.build.toplevel;
    phone-enchilada-script =
      inputs.self.nixosConfigurations.phone-enchilada.config.system.build.diskoImagesScript;
    phone-enchilada-mktarball = inputs.self.nixosConfigurations.phone-enchilada-tarball.config.system.build.tarball;
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
	      (tarball.lib.call { enableGenericExtlinux = false; })
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

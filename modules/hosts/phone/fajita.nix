{
  den,
  inputs,
  tarball,
  ...
}:
{
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

{ inputs, kernel, ... }:
{
  perSystem =
    { pkgs, ... }: kernel.lib.package-gen pkgs "phone" "aarch64-linux" pkgs.stdenv.hostPlatform.system;

  kernel.lib.sdm845 =
    pkgs:
    pkgs.fetchFromGitea {
      domain = "codeberg.org";
      owner = "sdm845";
      repo = "linux";
      rev = "949f86c36a31d8619ea1b18ea82d099cd752e86b";
      hash = "sha256-S2tNAb0dANRu9oRMYoumDO1u5zAkDXrM/kKwD9dwdnA=";
    };

  kernel.hosts.phone =
    pkgs: host: arch: system:
    (kernel.lib.linux {
      inherit
        pkgs
        host
        arch
        system
        ;
      structuredExtraConfig = kernel.config.default.phone;
      localVer = "sdm845";
      defconfig = "phone_defconfig";
      src = kernel.lib.kernel-cleaner {
        inherit pkgs;
        src = kernel.lib.sdm845 pkgs;
        arch = "arm64";
        defconfig = "phone_defconfig";
        removeLocalVersion = true;
        class = "qcom";
        dtbMake = ''
          dtb-\$(CONFIG_ARCH_QCOM) += sdm845-oneplus-enchilada.dtb
          dtb-\$(CONFIG_ARCH_QCOM) += sdm845-oneplus-fajita.dtb
        '';
        config = (
          pkgs.runCommand "qcom-defconfig" { } ''
            cp ${(kernel.lib.sdm845 pkgs)}/arch/arm64/configs/defconfig defconfig
            cp ${(kernel.lib.sdm845 pkgs)}/arch/arm64/configs/sdm845.config sdm845.config
            cat defconfig sdm845.config | sed '/CONFIG_LOCALVERSION/d' > $out
          ''
        );
      };
      patches =
        with kernel.patches.injector pkgs;
        cachyos.latest.inline
        ++ cachyos.latest.std
        ++ (tachyon.common { source = inputs.tachyon-patches-latest; })
        ++ (tachyon.latest { isPhone = true; })
        ++ (bunker.common { isLts = false; })
        ++ (bunker.latest { })
        ++ [ "${self}/modules/kernel/patches/files/oneplus-wcn3990-no-swctrl.patch" ];
    });
}

{
  inputs,
  kernel,
  self,
  ...
}:
{
  perSystem =
    { pkgs, ... }: kernel.lib.package-gen pkgs "phone" "aarch64-linux" pkgs.stdenv.hostPlatform.system;

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
        src = inputs.linux-sdm845;
        arch = "arm64";
        defconfig = "phone_defconfig";
        class = "qcom";
        dtbMake = ''
          dtb-\$(CONFIG_ARCH_QCOM) += sdm845-oneplus-enchilada.dtb
          dtb-\$(CONFIG_ARCH_QCOM) += sdm845-oneplus-fajita.dtb
        '';
        config = (
          pkgs.runCommand "qcom-defconfig" { } ''
            cp ${inputs.linux-sdm845}/arch/arm64/configs/defconfig defconfig
            cp ${inputs.linux-sdm845}/arch/arm64/configs/sdm845.config sdm845.config
            cat defconfig sdm845.config | sed '/CONFIG_LOCALVERSION/d' > $out
          ''
        );
      };
      patches =
        with kernel.patches.injector pkgs;
        [ "${self}/modules/kernel/patches/files/fix-qcom-smbx-init.patch" ]
        ++ cachyos.latest.inline
        ++ cachyos.latest.std
        ++ (tachyon.common { source = inputs.tachyon-patches-latest; })
        ++ (tachyon.latest { })
        ++ (bunker.common { isLts = false; })
        ++ (bunker.latest { });
    });
}

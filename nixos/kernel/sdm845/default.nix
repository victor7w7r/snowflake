{
  pkgs,
  kernelData,
  ...
}:
let
  configure = pkgs.callPackage ./configure.nix { inherit kernelData; };
  kconfigToNix = pkgs.callPackage ../generated/generate.nix { inherit configure; };
  /*
    installFlags = [ "INSTALL_MOD_PATH=$out" ];
      postInstall = ''
        mkdir -p $out1

        cp -v "$buildRoot/arch/arm64/boot/Image.gz" "$out/Image.gz"

        ln -sv Image.gz "$out/vmlinuz" || true
        cp .config $out/config-${configure.version}

        depmod -b "$out" -F "$buildRoot/System.map" "${configure.version}"
      '';
  */
  /*
    patches = configure.passthru.patches;
    kconfigFile = pkgs.writeText "kconfig-mobile" (
      lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: value: "${name}=${value}") (import ./config.aarch64-linux.nix)
      )
    );
  */
  build =
    (pkgs.mobile-nixos.kernel-builder {
      inherit (configure) src;
      configfile = ./sdm845.config;
      isModular = false;
      isCompressed = "gz";
      version = "${configure.version}${configure.passthru.localVer}";
      makeFlags = [ "LOCALVERSION=-v7w7r-sdm845" ];
      modDirVersion = "${configure.version}${configure.passthru.localVer}";
    })

    .overrideAttrs
      (attrs: {
        passthru = attrs.passthru // {
          inherit kconfigToNix configure;
        };

        postConfigure = ''
          sed -i 's/^CONFIG_BRIDGE=m/CONFIG_BRIDGE=y/' $buildRoot/.config
          sed -i 's/^CONFIG_BRIDGE_NETFILTER=m/CONFIG_BRIDGE_NETFILTER=y/' $buildRoot/.config
          sed -i 's/^CONFIG_IP6_NF_IPTABLES=m/CONFIG_IP6_NF_IPTABLES=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m/CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m/CONFIG_NETFILTER_XT_MATCH_PHYSDEV=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NETFILTER_XT_MATCH_SOCKET=m/CONFIG_NETFILTER_XT_MATCH_SOCKET=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NFT_BRIDGE_META=m/CONFIG_NFT_BRIDGE_META=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NFT_BRIDGE_REJECT=m/CONFIG_NFT_BRIDGE_REJECT=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NFT_REJECT=m/CONFIG_NFT_REJECT=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NFT_REJECT_IPV4=m/CONFIG_NFT_REJECT_IPV4=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NFT_REJECT_IPV6=m/CONFIG_NFT_REJECT_IPV6=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NFT_REJECT_NETDEV=m/CONFIG_NFT_REJECT_NETDEV=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NFT_SOCKET=m/CONFIG_NFT_SOCKET=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NFT_TPROXY=m/CONFIG_NFT_TPROXY=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NF_TABLES_BRIDGE=m/CONFIG_NF_TABLES_BRIDGE=y/' $buildRoot/.config
          sed -i 's/^CONFIG_NF_TPROXY_IPV6=m/CONFIG_NF_TPROXY_IPV6=y/' $buildRoot/.config
        '';
      });

in
{
  inherit build;
  packages = pkgs.linuxPackagesFor build;
}

{
  lib,
  pkgs,
  kernelData,
  ...
}:
let
  configure = pkgs.callPackage ./configure.nix { inherit kernelData; };
  kconfigToNix = pkgs.callPackage ../generated/generate.nix { inherit configure; };
  kconfigFile = pkgs.writeText "kconfig-mobile" (
    lib.concatStringsSep "\n" (
      lib.mapAttrsToList (name: value: "${name}=${value}") (import ./config.aarch64-linux.nix)
    )
  );
  build =
    let
      kernelFunc =
        { ... }:
        (pkgs.mobile-nixos.kernel-builder {
          inherit (configure) patches src;
          configfile = ./sdm845.config;
          isModular = true;
          isCompressed = "gz";
          version = "${configure.version}${configure.passthru.localVer}";
          makeFlags = [ "LOCALVERSION=${configure.passthru.localVer}" ];
          installTargets = [ "modules_install" ];
          nativeBuildInputs = with pkgs; [
            python3
            zstd
            kmod
          ];
          modDirVersion = "${configure.version}${configure.passthru.localVer}";
          postInstall = ''
            cp -v "$buildRoot/arch/arm64/boot/Image.gz" "$out/Image.gz"
            ln -sv Image.gz "$out/vmlinuz" || true
            depmod -b "$out" -F "$buildRoot/System.map" "${configure.version}${configure.passthru.localVer}"
          '';
        }).overrideAttrs
          (attrs: {
            passthru = attrs.passthru // {
              inherit kconfigToNix kconfigFile configure;
            };
            /*
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
            */
          });
    in
    (lib.makeOverridable kernelFunc) { };
in
{
  inherit build;
  packages = pkgs.linuxPackagesFor build;
}

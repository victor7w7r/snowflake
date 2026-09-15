{ inputs, tarball, ... }:
{
  imports = [ (inputs.den.namespace "tarball" false) ];

  tarball.lib = {
    call =
      {
        additionalContent ? "",
        additionalBuildInputs ? [ ],
        enableGenericExtlinux ? true,
        dtbpath ? "",
      }:
      {
        includes = [ tarball.lib.postscript ];

        nixos =
          {
            config,
            lib,
            pkgs,
            ...
          }:
          {
            system.build.kernelFiles = pkgs.stdenvNoCC.mkDerivation {
              name = "kernelFiles";
              buildCommand = ''
                mkdir -p $out
                cp "${config.system.build.initialRamdisk}/${config.system.boot.loader.initrdFile}" $out/initrd
                cp "${config.boot.kernelPackages.kernel}/${config.system.boot.loader.kernelFile}" $out/vmlinuz
              '';
            };

            system.build.bootFiles = pkgs.stdenvNoCC.mkDerivation {
              name = "bootFiles";
              nativeBuildInputs = with pkgs; [ zstd ] ++ additionalBuildInputs;
              buildCommand = ''
                mkdir -p $out
                ${config.boot.loader.generic-extlinux-compatible.populateCmd} \
                  -c ${config.system.build.toplevel} -d firmware/boot
                mv firmware/boot ./boot
                tar -cv -C boot . | zstd -T$NIX_BUILD_CORES > $out/boot.tar.zst
              '';
            };

            system.build.tarball = pkgs.stdenvNoCC.mkDerivation {
              name = "tarball";

              nativeBuildInputs =
                with pkgs;
                [
                  coreutils
                  gnutar
                  rsyncy
                  zstd
                  zstd
                ]
                ++ additionalBuildInputs;

              buildCommand =
                (pkgs.buildPackages.closureInfo { rootPaths = [ config.system.build.toplevel ]; })
                |> (closureInfo: ''
                  mkdir -p $out root/store

                  ${
                    if enableGenericExtlinux then
                      ''
                        ${config.boot.loader.generic-extlinux-compatible.populateCmd} \
                         -c ${config.system.build.toplevel} -d firmware/boot

                        mv firmware/boot ./boot
                        tar -cv -C boot . | zstd -T$NIX_BUILD_CORES > $out/boot.tar.zst
                      ''
                    else
                      ''
                        toplevel=${config.system.build.toplevel}
                        dtbpath=${dtbpath}
                        kernel_params=$(cat "$toplevel/kernel-params")
                        esp="staging"

                        mkdir -p $esp/EFI/BOOT $esp/EFI/systemd
                        cp ${lib.getLib pkgs.systemd}/lib/systemd/boot/efi/systemd-boot*.efi $esp/EFI/systemd
                        cp ${pkgs.systemd}/lib/systemd/boot/efi/* $esp/EFI/BOOT
                        booter=$(basename $(ls $esp/EFI/BOOT/systemd-*.efi))
                        mv $esp/EFI/BOOT/$booter $esp/EFI/BOOT/''${booter/systemd-/}

                        kernel=$(readlink "$toplevel/kernel")
                        kernel_name="''${kernel/\/nix\/store\//}"
                        kernel_name="''${kernel_name/\//-}"
                        efi_kernel="/EFI/nixos/$kernel_name.efi"
                        install -Dm644 "$kernel" "$esp/$efi_kernel"

                        initrd=$(readlink "$toplevel/initrd")
                        initrd_name="''${initrd/\/nix\/store\//}"
                        initrd_name="''${initrd_name/\//-}"
                        efi_initrd="/EFI/nixos/$initrd_name.efi"
                        install -Dm644 "$initrd" "$esp/$efi_initrd"

                        efi_dtb=
                        if [ -n "$dtbpath" ]; then
                          dtbs=$(readlink "$toplevel/dtbs")
                          dtbs_name="''${dtbs/\/nix\/store\//}"
                          dtbs_name="''${dtbs_name/\//-}"
                          efi_dtb="EFI/nixos/$dtbs_name-$(basename $dtbpath).efi"
                          install -Dm644 "$dtbs/$dtbpath" "$esp/$efi_dtb"
                        fi

                        install -Dm644 "${pkgs.edk2-uefi-shell}/shell.efi" "$esp/EFI/shell.efi"
                        install -Dm644 "${pkgs.writeText "poweroff.nsh" "reset -s"}" "$esp/EFI/poweroff.nsh"
                        install -Dm644 "${pkgs.writeText "reboot.nsh" "reset -c"}" "$esp/EFI/reboot.nsh"

                        mkdir -p $esp/loader/entries

                        cat > $esp/loader/entries/nixos-generation-0.conf <<EOF
                          title NixOS
                          sort-key nixos
                          version Generation 0 NixOS
                          linux $efi_kernel
                          initrd $efi_initrd
                          options init=$toplevel/init $kernel_params
                          ''${efi_dtb:+devicetree $efi_dtb}
                        EOF

                        cat > $esp/loader/entries/poweroff.conf <<EOF
                          title Apagar (Poweroff)
                         efi /EFI/shell.efi
                          options -e -noexit /EFI/poweroff.nsh
                        EOF

                        cat > $esp/loader/entries/reboot.conf <<EOF
                          title Reiniciar (Reboot)
                          efi /EFI/shell.efi
                          options -e -noexit /EFI/reboot.nsh
                        EOF

                        cat > $esp/loader/loader.conf <<EOF
                          timeout 5
                          default nixos-generation-0.conf
                          console-mode keep
                        EOF

                        tar -cv -C $esp . | zstd -T$NIX_BUILD_CORES > $out/boot.tar.zst
                      ''
                  }

                  ${if additionalContent != "" then additionalContent else ""}

                  rsyncy -aHAxr --no-o --no-g --files-from=${closureInfo}/store-paths / root/store
                  cp ${closureInfo}/registration root/nix-path-registration
                  mkdir -p root/var/nix/daemon-socket && chmod -R +w root
                  mv root/store/nix/store/* root/store/ && rm -rf root/store/nix
                  chmod -R a-w root/store
                  tar --owner=0 --group=0 --numeric-owner -cv -C root . | zstd -T$NIX_BUILD_CORES > $out/store.tar.zst
                '');
            };
          };
      };

    postscript.nixos =
      { config, ... }:
      {
        boot.postBootCommands = ''
          set -euo pipefail
          set -x

          REG_FILE="/nix/nix-path-registration"

          ${config.nix.package.out}/bin/nix-store --load-db < "$REG_FILE"
          touch /etc/NIXOS
          ${config.nix.package.out}/bin/nix-env -p /nix/var/nix/profiles/system --set /run/current-system
          rm -f "$REG_FILE"
        '';
      };
  };
}

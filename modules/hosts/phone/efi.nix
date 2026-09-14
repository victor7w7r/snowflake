{ inputs, ... }:
{
  perSystem.packages = {
    phone-enchilada-efibuild =
      inputs.self.nixosConfigurations.phone-enchilada.config.system.build.efibuild;

    phone-fajita-efibuild = inputs.self.nixosConfigurations.phone-fajita.config.system.build.efibuild;
  };

  den.aspects.phone.efi.nixos =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      system.build.efibuild = pkgs.stdenvNoCC.mkDerivation {
        name = "efibuild";
        nativeBuildInputs = with pkgs; [
          gnutar
          zstd
          coreutils
        ];
        buildCommand = ''
          toplevel=${config.system.build.toplevel}
          dtbpath=${config.hardware.deviceTree.name}
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

          tar -I 'zstd -19 -T0' -cvf "$out" -C $esp .
        '';
      };
    };
}

{
  pkgs,
  host,
  inputs,
  config,
  ...
}:
let
  efi = "/boot/EFI";
  cat = "${pkgs.coreutils}/bin/cat";
  cp = "${pkgs.coreutils}/bin/cp";
  mv = "${pkgs.coreutils}/bin/mv";
  rm = "${pkgs.coreutils}/bin/rm";
  mkdir = "${pkgs.coreutils}/bin/mkdir";
  refind = "${pkgs.refind}/share/refind";
  awk = "${pkgs.gawk}/bin/awk";
  sbctl = "${pkgs.sbctl}/bin/sbctl";
  edk2 = pkgs.edk2-uefi-shell;
  memtest = pkgs.memtest86-efi;
  head = "${pkgs.coreutils}/bin/head";
  fwupd = "${pkgs.fwupd-efi}/libexec/fwupd/efi";
  grep = "${pkgs.gnugrep}/bin/grep";
  efibootmgr = "${pkgs.efibootmgr}/bin/efibootmgr";
  lsblk = "${pkgs.util-linux}/bin/lsblk";
  sed = "${pkgs.gnused}/bin/sed";
  wget = "${pkgs.wget2}/bin/wget2";
  efifs = "https://github.com/pbatard/EfiFs/releases/download/v1.11";
  mocha = "themes/catppuccin/assets/mocha";
  initrd = "${config.system.build.initialRamdisk}/${config.system.boot.loader.initrdFile}";
  latest = config.boot.kernelPackages.kernel;
  kernelFile = config.system.boot.loader.kernelFile;

  debugFlags = "boot.trace=1 debug udev.log_level=7 rd.systemd.show_status=true";
in
{
  system.boot.loader.id = "refind";
  system.build.installBootLoader = pkgs.writeScript "boot-loader" ''
    #!${pkgs.bash}/bin/bash

    TOPLEVEL=$1

    [[ ! -d ${efi}/BOOT ]] && ${mkdir} -p ${efi}/BOOT

    if [ ! -d ${efi}/refind ]; then
      echo "Setup Refind"

      [[ -f ${efi}/BOOT/BOOTX64.efi ]] && ${rm} ${efi}/BOOT/BOOTX64.efi

      ${cp} -r ${refind} ${efi}/
      ${cp} ${refind}/refind_x64.efi ${efi}/BOOT/BOOTX64.efi

      ${rm} -rf ${efi}/refind/docs ${efi}/refind/refind.conf-sample ${efi}/refind/images ${efi}/refind/drivers_x64/ext*
      ${rm} -rf ${efi}/refind/drivers_x64/hfs_x64.efi
      ${rm} -rf ${efi}/refind/drivers_x64/iso9660_x64.efi ${efi}/refind/drivers_x64/reiserfs_x64.efi
      ${mkdir} -p ${efi}/refind/themes && ${cp} -r ${inputs.catppuccin-refind} ${efi}/refind/themes/catppuccin

      ${cp} ${memtest}/BOOTX64.efi ${efi}/refind/tools_x64/memtest86.efi
      ${cp} ${fwupd}/fwupdx64.efi ${efi}/refind/tools_x64/fwupx64.efi

      if [ ! -d ${efi}/tools ]; then
       ${mv} ${efi}/refind/tools_x64 ${efi}/tools
       ${cp} ${edk2}/shell.efi ${efi}/tools/shellx64.efi
      fi
    fi

    EFI_INFO=$(${lsblk} -o NAME,PARTTYPE,PKNAME,PARTTYPENAME,FSTYPE \
      | ${grep} -i "EFI" | ${grep} -i "vfat" | ${head} -n1)
    DISK=$(echo "$EFI_INFO" | ${awk} '{print $3}')

    echo "Setup EFI Entries..."
    ${efibootmgr} | ${grep} -i "rEFind" | ${awk} '{print $1}' \
      | ${sed} 's/Boot//' | ${sed} 's/\*//' \
      | while read entry; do ${efibootmgr} -b "$entry" -B &> /dev/null; done

    ${efibootmgr} --create --disk /dev/$DISK --part 1 \
      --loader /EFI/refind/refind_x64.efi --label "rEFInd" \
      --unicode &> /dev/null

    [[ -f ${efi}/vmlinuz ]] && ${rm} ${efi}/vmlinuz
    [[ -f ${efi}/initrd ]] && ${rm} ${efi}/initrd

    ${cp} ${latest}/${kernelFile} ${efi}/vmlinuz
    ${cp} ${initrd} ${efi}/initrd

    echo "$BASE" >> ${efi}/versions.txt
    #${cp} ${initrd} /boot/emergency/initrd_$TOPLEVEL

    ${cat} > ${efi}/refind/refind.conf << EOF
      banner ${mocha}/background.png
      banner_scale fillscreen
      dont_scan_dirs +,EFI
      enable_touch
      enable_mouse
      icons_dir ${mocha}/icons
      hideui hwtest,arrows,badges
      scanfor manual,external,internal
      showtools shell, memtest, bootorder, apple_recovery, windows_recovery
      dont_scan_dirs ESP:/EFI/BOOT,EFI/refind,EFI/tools,emergency
      selection_big ${mocha}/selection_big.png
      selection_small ${mocha}/selection_small.png
      timeout 2
      use_nvram false

      menuentry "NixOS" {
        icon /EFI/refind/${mocha}/icons/os_nixos.png
        loader /EFI/vmlinuz
        initrd /EFI/initrd
        ostype Linux
        options "init=$TOPLEVEL/init ${toString config.boot.kernelParams}"
        submenuentry "Verbose" {
          add_options "${debugFlags}"
        }
        submenuentry "Console Only" {
          add_options "systemd.unit=multi-user.target"
        }
        submenuentry "Rescue" {
          add_options "systemd.unit=rescue.target"
        }
      }
    EOF
    ${
      if host != "v7w7r-macmini81" then
        ''
          if [ -d /var/lib/sbctl/keys ]; then
            ${sbctl} sign -s ${efi}/refind/refind_x64.efi &> /dev/null
            ${sbctl} sign -s ${efi}/tools/shellx64.efi &> /dev/null
            ${sbctl} sign -s ${efi}/tools/memtest86.efi &> /dev/null
            ${sbctl} sign -s ${efi}/tools/fwupx64.efi &> /dev/null
            ${sbctl} sign -s ${efi}/refind/drivers_x64/btrfs_x64.efi &> /dev/null
            ${sbctl} sign -s ${efi}/refind/drivers_x64/ntfs_x64.efi &> /dev/null
            ${sbctl} sign -s ${efi}/nixos.efi
          fi
        ''
      else
        ""
    }
  '';
}

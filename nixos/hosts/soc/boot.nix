{
  bootSize,
  persistSize,
  populateFirmwareCommands,
}:
''
  echo "Creating boot partition..."
  gap=8
  bootSizeMB=${toString bootSize}
  persistSizeMB=${toString persistSize}

  bootImgSize=$(( (gap + bootSizeMB + persistSizeMB) * 1024 * 1024 + 16 * 1024 * 1024 ))

  truncate -s $bootImgSize boot.img

  sfdisk --no-reread --no-tell-kernel boot.img <<EOF
    label: dos
    label-id: 0x2178694e

    start=''${gap}M, size=''${bootSizeMB}M, type=b, bootable

    start=$((gap + bootSizeMB))M, size=''${persistSizeMB}M, type=83
  EOF

  eval $(partx boot.img -o START,SECTORS --nr 1 --pairs)
  truncate -s $((SECTORS * 512)) firmware_part.img
  mkfs.vfat --invariant -i 0x2178694e -n BOOT firmware_part.img
  mkdir firmware

  echo "Populating firmware..."
  ${populateFirmwareCommands}

  find firmware -exec touch --date=2000-01-01 {} +
  cd firmware
  for d in $(find . -type d -mindepth 1 | sort); do
    faketime "2000-01-01 00:00:00" mmd -i ../firmware_part.img "::/$d"
  done
  for f in $(find . -type f | sort); do
    mcopy -pvm -i ../firmware_part.img "$f" "::/$f"
  done
  cd ..

  fsck.vfat -vn firmware_part.img
  dd conv=notrunc if=firmware_part.img of=boot.img seek=$START count=$SECTORS
  eval $(partx boot.img -o START,SECTORS --nr 2 --pairs)
''

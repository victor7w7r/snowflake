{
  pkgs,
  kernelData,
  majorMinor ? null,
  hardened ? false,
  ...
}:
{
  linux = pkgs.fetchurl {
    url = kernelData.linux.url;
    hash = kernelData.linux.hash;
  };

  linux-legacy = pkgs.fetchurl {
    url = kernelData.linux-legacy.url;
    hash = kernelData.linux-legacy.hash;
  };

  linux-legacy-hardened = pkgs.fetchurl {
    url = kernelData.linux-legacy-hardened.url;
    hash = kernelData.linux-legacy-hardened.hash;
    postFetch = ''
      ${''
        ${pkgs.patchutils}/bin/filterdiff -x "*/arch/Kconfig" \
        -x "*/include/linux/user_namespace.h" \
        -x "*/kernel/sysctl.c" \
        -x "*/kernel/user_namespace.c" \
        "$out" > temp.patch || true
        cat temp.patch > "$out" || true
      ''}
    '';
  };

  asus = pkgs.fetchgit {
    url = kernelData.asus.url;
    rev = kernelData.asus.rev;
    sha256 = kernelData.asus.hash;
    postFetch = ''find "$out" -type f ! -name "*.patch" -delete'';
  };

  tachyon = pkgs.fetchgit {
    url = kernelData.tachyon.url;
    rev = kernelData.tachyon.rev;
    sha256 = kernelData.tachyon.hash;
  };

  bunker = pkgs.fetchFromGitHub {
    owner = kernelData.bunker.user;
    repo = kernelData.bunker.repo;
    rev = kernelData.bunker.rev;
    hash = kernelData.bunker.hash;
  };

  kConfig = pkgs.fetchFromGitHub {
    owner = kernelData.user;
    repo = kernelData.config.repo;
    rev = kernelData.config.rev;
    sha256 = if hardened then kernelData.config.hashHardened else kernelData.config.hash;
    postFetch = ''
      hold="$(mktemp -d)" && conf="$hold/conf"
      cp "$out/linux-cachyos-${if hardened then "hardened" else "lts"}/config" "$conf"
      rm -rfv "$out" && cp -v "$conf" "$out"
    '';
  };

  patches = pkgs.fetchFromGitHub {
    owner = kernelData.user;
    repo = kernelData.patches.repo;
    rev = kernelData.patches.rev;
    sha256 = kernelData.patches.hash;
    postFetch = ''
      find "$out" -type d -empty -delete
        ${''
          ${pkgs.patchutils}/bin/filterdiff -x "*/drivers/gpu/drm/amd/*" \
          "$out/${majorMinor}/0007-hdmi.patch" > hdmi-filter.patch || true
          cat hdmi-filter.patch > "$out/${majorMinor}/0007-hdmi.patch" || true

          ${pkgs.patchutils}/bin/filterdiff -x "*/drivers/hid/Makefile" \
          -x "*/drivers/input/joystick/xpad.c" \
          "$out/${majorMinor}/misc/0001-handheld.patch" > handheld-filter.patch || true
          cat handheld-filter.patch > "$out/${majorMinor}/misc/0001-handheld.patch" || true
        ''}
    '';
  };

  armbian = pkgs.fetchFromGitHub {
    owner = kernelData.armbian.user;
    repo = kernelData.armbian.repo;
    rev = kernelData.armbian.rev;
    hash = kernelData.armbian.hash;
  };

  uwe5622 = pkgs.fetchFromGitHub {
    owner = kernelData.uwe5622.user;
    repo = kernelData.uwe5622.repo;
    rev = kernelData.uwe5622.rev;
    hash = kernelData.uwe5622.hash;
  };

  sdm845 = pkgs.fetchFromGitLab {
    owner = kernelData.sdm845.user;
    repo = kernelData.sdm845.repo;
    rev = kernelData.sdm845.rev;
    hash = kernelData.sdm845.hash;
  };

}

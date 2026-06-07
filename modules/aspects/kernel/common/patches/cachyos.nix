{
  kernel.patches.cachyos =
    { pkgs, majorMinor }:
    let
      patch = pkgs.lib.trivial.importJSON ./patches.json;
      patches = pkgs.fetchFromGitHub {
        owner = patch.cachyos.user;
        repo = patch.cachyos.repo;
        rev = patch.cachyos.rev;
        sha256 = patch.cachyos.hash;
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

              ${pkgs.patchutils}/bin/filterdiff -x "*/security/selinux/selinuxfs.c" \
              "$out/${majorMinor}/misc/0001-hardened.patch" > hardened-filter.patch || true
              cat hardened-filter.patch > "$out/${majorMinor}/misc/0001-hardened.patch" || true
            ''}
        '';
      };
      bore = [ "${patches}/${majorMinor}/sched/0001-bore-cachy.patch" ];
      optimization = [
        "${patches}/${majorMinor}/misc/0001-clang-polly.patch"
        "${patches}/${majorMinor}/misc/dkms-clang.patch"
        "${patches}/${majorMinor}/misc/poc-selector.patch"
      ];
      governors = [
        "${patches}/${majorMinor}/misc/reflex-governor.patch"
        "${patches}/${majorMinor}/misc/nap-governor.patch"
      ];
    in
    {
      inherit bore optimization governors;
      common = bore ++ optimization ++ governors;
      hardened = [ "${patches}/${majorMinor}/misc/0001-hardened.patch" ];
      handheld = [
        "${patches}/${majorMinor}/misc/0001-acpi-call.patch"
        "${patches}/${majorMinor}/misc/0001-handheld.patch"
      ];
    };
}

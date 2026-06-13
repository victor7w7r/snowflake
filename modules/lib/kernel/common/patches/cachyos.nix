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
              ${pkgs.patchutils}/bin/filterdiff -x "*/kernel/sched/fair.c" \
              "$out/${majorMinor}/sched/0001-bore-cachy.patch" > bore-filter.patch || true
              cat bore-filter.patch > "$out/${majorMinor}/sched/0001-bore-cachy.patch" || true
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

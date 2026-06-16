{
  kernel.patches.cachyos =
    pkgs: majorMinor:
    let
      inherit majorMinor;
      patches = pkgs.stdenvNoCC.mkDerivation {
        pname = "patches-cachyos";
        version = "custom";
        src =
          with (pkgs.lib.trivial.importJSON ./patches.json).cachyos;
          pkgs.fetchFromGitHub {
            inherit
              repo
              rev
              owner
              sha256
              ;
          };

        dontPatch = true;
        dontFixup = true;
        dontUnpack = true;

        nativeBuildInputs = with pkgs; [
          findutils
          patchutils
        ];

        configurePhase = "cp -r $src/* ./";
        buildPhase = ''
          find . -type d -empty -delete
          chmod -R +w .
          filterdiff -x "*/kernel/sched/fair.c" \
            "./${majorMinor}/sched/0001-bore-cachy.patch" > bore-filter.patch || true
          cat bore-filter.patch > "./${majorMinor}/sched/0001-bore-cachy.patch" || true

          filterdiff -x "*/drivers/input/joystick/xpad.c" \
            "./${majorMinor}/misc/0001-handheld.patch" > handheld-filter.patch || true
          cat handheld-filter.patch > "./${majorMinor}/misc/0001-handheld.patch" || true

            filterdiff -x "*/security/selinux/selinuxfs.c" \
              "./${majorMinor}/misc/0001-hardened.patch" > hardened-filter.patch || true
            cat hardened-filter.patch > "./${majorMinor}/misc/0001-hardened.patch" || true
        '';
        installPhase = "mkdir -p $out && cp -r . $out/";
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

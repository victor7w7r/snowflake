{ lib, ... }:
{
  kernel.patches.asus =
    { pkgs }:
    let
      patch = pkgs.lib.trivial.importJSON ./patches.json;
      asus = pkgs.fetchgit {
        url = patch.asus.url;
        rev = patch.asus.rev;
        sha256 = patch.asus.hash;
        postFetch = ''find "$out" -type f ! -name "*.patch" -delete'';
      };
    in
    lib.map (p: "${asus.outPath}/${p}") [
      "0002-platform-x86-asus-armoury-add-keyboard-control-firmw.patch"
      "0040-workaround_hardware_decoding_amdgpu.patch"
      "0070-acpi-x86-s2idle-Add-ability-to-configure-wakeup-by-A.patch"
      "0081-amdgpu-adjust_plane_init_off_by_one.patch"
      "asus-patch-series.patch"
      "PATCH-v5-00-11-Improvements-to-S5-power-consumption.patch"
      "v2-0002-hid-asus-change-the-report_id-used-for-HID-LED-co.patch"
    ];
}

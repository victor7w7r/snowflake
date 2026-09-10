{
  inputs,
  kernel-versions,
  lib,
  self,
  ...
}:
{
  flake-file.inputs = {
    cachyos-patches = {
      url = "github:CachyOS/kernel-patches";
      flake = false;
    };

    cachyos-patches-unsync = {
      url = "github:CachyOS/kernel-patches/c1ba300617a12d257b5721572b9bbe28efae182f";
      flake = false;
    };
  };

  kernel.patches = {
    cachyos-defconfig =
      {
        pkgs,
        selector ? "",
      }:
      pkgs.runCommand "cachyos-defconfig" { } ''
        cp "${inputs.linux-config}/linux-cachyos${
          if selector == "" then "" else "-${selector}"
        }/config" $out
      '';

    cachyos = pkgs: {
      latest = {
        bore =
          map
            (
              patch:
              "${inputs.cachyos-patches}/${lib.versions.majorMinor kernel-versions.latest}/sched/${patch}.patch"
            )
            [
              #"0001-bore-cachy"
            ];
        std =
          map
            (
              patch:
              "${inputs.cachyos-patches}/${lib.versions.majorMinor kernel-versions.latest}/misc/${patch}.patch"
            )
            [
              #"dkms-clang"
            ];
        handheld =
          map
            (
              patch:
              "${inputs.cachyos-patches}/${lib.versions.majorMinor kernel-versions.latest}/misc/${patch}.patch"
            )
            [
              "0001-acpi-call"
              "0001-handheld"
            ];

        inline =
          "${self}/modules/kernel/patches/cachyos-7.2"
          |> builtins.readDir
          |> builtins.attrNames
          |> builtins.filter (
            filename:
            !builtins.elem filename [
              "0005-mm-swap-Disable-swap-in-readahead.patch"
              "0079-ksm-add-linear_page_index-into-ksm_rmap_item.patch"
              "0080-ksm-Optimize-rmap_walk_ksm-by-passing-a-suitable-pag.patch"
              "0081-ksm-add-mremap-selftests-for-ksm_rmap_walk.patch"
              "0082-sched-core-Fix-inter-class-wakeup_preempt.patch"
              "0083-sched-fair-Fix-overflow-in-update_tg_cfs_runnable.patch"
              "0085-sched-fair-Add-cgroup_mode-up.patch"
              "0086-sched-fair-Add-cgroup_mode-max.patch"
              "0087-sched-fair-Add-cgroup_mode-concur.patch"
              "0088-sched-fair-Add-cgroup_mode-tasks.patch"
              "0089-sched-fair-Change-the-default-cgroup_mode-to-concur.patch"
              "0090-sched-eevdf-Move-to-a-single-runqueue.patch"
              "0119-list-Mark-some-functions-as-__always_inline.patch"
              "0125-smp-Disable-preemption-explicitly-in-__csd_lock_wait.patch"
              "0126-smp-Enable-preemption-early-in-smp_call_function_sin.patch"
              "0127-smp-Refactor-remote-CPU-selection-in-smp_call_functi.patch"
            ]
          )
          |> map (filename: "${self}/modules/kernel/patches/cachyos-7.2/${filename}");

      };

      lts =
        {
          isHardened ? false,
        }:
        pkgs.runCommand "cachyos-patches-lts-diff"
          {
            nativeBuildInputs = with pkgs; [
              findutils
              patchutils
            ];
          }
          ''
            mkdir -p $out
            cp -r ${inputs.cachyos-patches-unsync}/* ./
            chmod -R +w . && find . -type d -empty -delete
            filterdiff -x "*/security/selinux/selinuxfs.c" "${lib.versions.majorMinor kernel-versions.lts}/misc/0001-hardened.patch" > 0001-hardened-filter.patch
            cat 0001-hardened-filter.patch > "${lib.versions.majorMinor kernel-versions.lts}/misc/0001-hardened.patch"
            rm 0001-hardened-filter.patch && mv ./* $out/
          ''
        |> (
          src:
          map (patch: "${src}/${lib.versions.majorMinor kernel-versions.lts}/${patch}.patch") [
            "misc/0001-aufs-6.18-merge-v20251208"
            "misc/0001-clang-polly"
            "misc/dkms-clang"
            "misc/nap-governor"
          ]
          ++ (pkgs.lib.optional isHardened "${src}/${lib.versions.majorMinor kernel-versions.lts}/misc/0001-hardened.patch")
        )
        |> lib.sort lib.lessThan;
    };
  };
}

{
  kernel.patches.tachyon =
    pkgs:
    let
      tachyon =
        with (pkgs.lib.trivial.importJSON ./patches.json).tachyon;
        pkgs.fetchgit {
          inherit
            url
            rev
            sha256
            ;
        };
    in
    {
      common = [
        #"${tachyon}/patches/0001-add-umonitor-umwait-C0.x-C-states.patch"
        #"${tachyon}/patches/0001-mm-memcontrol-add-some-branch-hints-based-on-gcov-an.patch"
        #"${tachyon}/patches/0001-sched-migrate.patch"
        #"${tachyon}/patches/0002-sched-core-add-some-branch-hints-based-on-gcov-analy.patch"
        #"${tachyon}/patches/0002-mm-disable-proactive-compaction-by-de.patch"
        "${tachyon}/patches/0003-mm-stop-kswapd-early-when-nothings-wa.patch"
        #"${tachyon}/patches/0005-mm-increment-kswapd_waiters-for-throt.patch" #ERROR
        "${tachyon}/patches/0002-sched-migrate.patch"
        "${tachyon}/patches/0050-Revert-ext4-do-not-create-EA-inode-under-buffer-lock.patch"
        "${tachyon}/patches/0102-increase-the-ext4-default-commit-age.patch"
        #"${tachyon}/patches/0107-bootstats-add-printk-s-to-measure-boot-time-in-more-.patch"
        "${tachyon}/patches/0108-smpboot-reuse-timer-calibration.patch"
        #"${tachyon}/patches/0110-give-rdrand-some-credit.patch"
        "${tachyon}/patches/0111-ipv4-tcp-allow-the-memory-tuning-for-tcp-to-go-a-lit.patch"
        "${tachyon}/patches/0112-init-wait-for-partition-and-retry-scan.patch"
        "${tachyon}/patches/0113-print-fsync-count-for-bootchart.patch"
        "${tachyon}/patches/0114-add-boot-option-to-allow-unsigned-modules.patch"
        "${tachyon}/patches/0115-enable-stateless-firmware-loading.patch"
        "${tachyon}/patches/0116-migrate-some-systemd-defaults-to-the-kernel-defaults.patch"
        "${tachyon}/patches/0117-xattr-allow-setting-user.-attributes-on-symlinks-by-.patch"
        #"${tachyon}/patches/0118-add-scheduler-turbo3-patch.patch"
        "${tachyon}/patches/0120-do-accept-in-LIFO-order-for-cache-efficiency.patch"
        "${tachyon}/patches/0175-readdir-add-unlikely-hint-on-len-check.patch"
        "${tachyon}/patches/0122-ata-libahci-ignore-staggered-spin-up.patch"
        "${tachyon}/patches/0125-nvme-workaround.patch"
        "${tachyon}/patches/0126-don-t-report-an-error-if-PowerClamp-run-on-other-CPU.patch"
        "${tachyon}/patches/0127-lib-raid6-add-patch.patch"
        #"${tachyon}/patches/0129-mm-wakeups-remove-a-wakeup.patch"
        "${tachyon}/patches/0131-add-a-per-cpu-minimum-high-watermark-an-tune-batch-s.patch"
        #"${tachyon}/patches/0132-prezero-20220308.patch"
        "${tachyon}/patches/0133-novector.patch"
        "${tachyon}/patches/0135-initcall-only-print-non-zero-initcall-debug-to-speed.patch"
        "${tachyon}/patches/0136-crypto-kdf-make-the-module-init-call-a-late-init-cal.patch"
        "${tachyon}/patches/0161-ACPI-align-slab-buffers-for-improved-memory-performa.patch"
        #"${tachyon}/patches/0162-extra-optmization-flags.patch"
        "${tachyon}/patches/0163-thermal-intel-powerclamp-check-MWAIT-first-use-pr_wa.patch"
        "${tachyon}/patches/0166-sched-fair-remove-upper-limit-on-cpu-number.patch"
        "${tachyon}/patches/0167-net-sock-increase-default-number-of-_SK_MEM_PACKETS-.patch"
        "${tachyon}/patches/0173-cpuidle-psd-add-power-sleep-demotion-prevention-for-.patch"
        "${tachyon}/patches/0174-memcg-increase-MEMCG_CHARGE_BATCH-to-127.patch"
        #"${tachyon}/patches/0175-readdir-add-unlikely-hint-on-len-check.patch"
        "${tachyon}/patches/better_idle_balance.patch"
        "${tachyon}/patches/epp-retune.patch"
        "${tachyon}/patches/libsgrowdown.patch"
        "${tachyon}/patches/mmput_async.patch"
        #"${tachyon}/patches/netscale.patch"
        "${tachyon}/patches/posted_msi.patch"
        "${tachyon}/patches/ratelimit-sched-yield.patch"
        #"${tachyon}/patches/revert-regression.patch"
        "${tachyon}/patches/scale-net-alloc.patch"
        #"${tachyon}/patches/scale.patch"
        "${tachyon}/patches/slack.patch"
      ];

      gaming = [
        "${tachyon}/patches/0158-clocksource-only-perform-extended-clocksource-checks.patch"
      ];

      notGaming = [
        "${tachyon}/patches/0128-itmt_epb-use-epb-to-scale-itmt.patch"
      ];
    };
}

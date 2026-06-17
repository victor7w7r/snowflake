{
  kernel.patches.bunker =
    pkgs:
    let
      bunker =
        with (pkgs.lib.trivial.importJSON ./patches.json).bunker;
        pkgs.fetchFromGitHub {
          inherit
            repo
            rev
            owner
            sha256
            ;
        };
    in
    {
      common = [
        "${bunker}/patches/6.18/bunker/0006-enable-kstack_erase-by-default.patch"
        "${bunker}/patches/6.18/bunker/0008-disable-proc_kcore-by-default.patch"
        "${bunker}/patches/6.18/clear/0001-net-dst-reduce-false-sharing-in-dst_entry.patch"
        "${bunker}/patches/6.18/clear/0009-mm-compaction-increase-proactive-compaction-check-in.patch"
        "${bunker}/patches/6.18/clear/0010-sched-core-add-branch-hints-based-on-gcov-analysis.patch"
        "${bunker}/patches/6.18/clear/0012-pci-increase-PME-check-interval-to-4-seconds.patch"
        "${bunker}/patches/6.18/cachyos/0017-mm-add-missing-extern-declarations-for-le9-workingse.patch"
        "${bunker}/patches/6.18/cachyos/0018-x86-cpu-bugs-VMSCAPE-BHB-clear-mitigation.patch"
        "${bunker}/patches/6.18/cachyos/0019-drm-VESA-DSC-BPP-pass-through-timings.patch"
        "${bunker}/patches/6.18/cachyos/0022-drivers-net-add-Realtek-R8125-R8126-5GbE-driver.patch"
        "${bunker}/patches/6.18/cachyos/0023-cpuidle-prefer-teo-over-menu-governor.patch"
        "${bunker}/patches/6.18/grapheneos/0001-disable-ldisc_autoload-by-default.patch"
        "${bunker}/patches/6.18/grapheneos/0002-disable-binfmt_misc-by-default.patch"
        "${bunker}/patches/6.18/grapheneos/0004-disable-memory_hotplug-by-default.patch"
        "${bunker}/patches/6.18/grapheneos/0005-usb-extend-deny_new_usb-to-gadget-interfaces.patch"
        "${bunker}/patches/6.18/zen/0009-mm-set-default-max-map-count-to-INT_MAX-5.patch"
        "${bunker}/patches/6.18/xanmod/0001-sched-fair-set-tunable-latencies-to-unscaled.patch"
        "${bunker}/patches/6.18/xanmod/0003-block-set-rq_affinity-to-force-complete-I-O-on-same-.patch"
        "${bunker}/patches/6.18/xanmod/0004-block-mq-deadline-disable-front_merges-by-default.patch"
        "${bunker}/patches/6.18/xanmod/0005-block-mq-deadline-increase-write-priority-to-improve.patch"
        "${bunker}/patches/6.18/xanmod/0006-vfs-decrease-rate-at-which-caches-are-reclaimed.patch"
        "${bunker}/patches/6.18/xanmod/0008-wait-allow-__wake_up_pollfree-from-GPL-modules.patch"
        "${bunker}/patches/6.18/xanmod/0009-file-export-file_close_fd-for-GPL-modules.patch"
        "${bunker}/patches/6.18/xanmod/0010-binder-give-binder_alloc-its-own-debug-mask-file.patch"
        "${bunker}/patches/6.18/xanmod/0011-binder-turn-into-loadable-module.patch"
        "${bunker}/patches/6.18/xanmod/0012-tcp-add-sysctl-to-skip-collapse-when-receive-buffer-.patch"
        "${bunker}/patches/6.18/xanmod/0014-dm-crypt-Disable-workqueues-for-crypto-ops.patch"
        "${bunker}/patches/6.18/xanmod/0015-kbuild-add-sms-based-software-pipelining-flags.patch"

        "${bunker}/patches/6.18/upstream/0002-time-timecounter-inline-timecounter_cyc2time.patch"
        "${bunker}/patches/6.18/upstream/0003-x86-lib-inline-csum_ipv6_magic.patch"
        "${bunker}/patches/6.18/upstream/0004-x86-apic-inline-x2apic_send_IPI_dest.patch"
        "${bunker}/patches/6.18/upstream/0005-cpuidle-menu-remove-incorrect-unlikely-annotation.patch"
        "${bunker}/patches/6.18/upstream/0007-tcp-inline-tcp_filter.patch"
        "${bunker}/patches/6.18/upstream/0008-ipv6-optimize-fl6_update_dst.patch"
        "${bunker}/patches/6.18/upstream/0009-net_sched-sch_fq-rework-fq_gc-to-avoid-stack-canary.patch"
        "${bunker}/patches/6.18/upstream/0010-tcp-use-__skb_push-in-__tcp_transmit_skb.patch"
        "${bunker}/patches/6.18/upstream/0011-ipv6-do-not-use-skb_header_pointer-in-icmpv6_filter.patch"
        "${bunker}/patches/6.18/upstream/0012-tcp-split-tcp_check_space-in-two-parts.patch"
        "${bunker}/patches/6.18/upstream/0014-drm-amdgpu-use-GFP_ATOMIC-instead-of-NOWAIT-in-the-c.patch"
        "${bunker}/patches/6.18/upstream/0015-btf-optimize-type-lookup-with-binary-search.patch"
        "${bunker}/patches/6.18/upstream/0016-btf-verify-btf-sorting.patch"
        "${bunker}/patches/6.18/upstream/0018-slab-introduce-kmalloc_flex-and-family.patch"
        "${bunker}/patches/6.18/upstream/0019-mount-add-OPEN_TREE_NAMESPACE.patch"
      ];

      hardened = [
        "${bunker}/patches/6.18/hardened/0001-add-sysctl-to-allow-disabling-unprivileged-CLONE_NEW.patch"
        "${bunker}/patches/6.18/hardened/0002-security-add-config-for-default-of-unprivileged_user.patch"
      ];
    };

}

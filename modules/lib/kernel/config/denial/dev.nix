{
  kernel.config.denial.dev = rec {
    all = debug // trace;

    debug = {
      ACPI_DEBUG = "n";
      DEBUG_FS = "n";
      DEBUG_MISC = "n";
      DEBUG_PREEMPT = "n";
      LATENCYTOP = "n";
      PM_ADVANCED_DEBUG = "n";
      PM_DEBUG = "n";
      PM_SLEEP_DEBUG = "n";
      SCHED_DEBUG = "n";
      SLUB_DEBUG = "n";
    };

    trace = {
      AGP = "n";
      BLK_DEV_IO_TRACE = "n";
      BOOTTIME_TRACING = "n";
      DYNAMIC_FTRACE = "n";
      DYNAMIC_FTRACE_WITH_ARGS = "n";
      DYNAMIC_FTRACE_WITH_DIRECT_CALLS = "n";
      DYNAMIC_FTRACE_WITH_REGS = "n";
      EVENT_TRACING = "n";
      FTRACE_MCOUNT_USE_OBJTOOL = "n";
      FTRACE_SYSCALLS = "n";
      FUNCTION_GRAPH_TRACER = "n";
      FUNCTION_TRACER = "n";
      GENERIC_TRACER = "n";
      HAMRADIO = "n";
      HIST_TRIGGERS = "n";
      HWLAT_TRACER = "n";
      IKCONFIG = "n";
      IKCONFIG_PROC = "n";
      INTERCONNECT = "n";
      KPROBES_ON_FTRACE = "n";
      KPROBE_EVENTS = "n";
      MCTP = "n";
      MMIOTRACE = "n";
      MPLS = "n";
      MTD = "n";
      NOP_TRACER = "n";
      PRINTK_TIME = "n";
      SCHED_TRACER = "n";
      STACKTRACE = "n";
      STACKTRACE_BUILD_ID = "n";
      STACKTRACE_SUPPORT = "n";
      STACK_TRACER = "n";
      SYSCTL_EXCEPTION_TRACE = "n";
      TASKS_TRACE_RCU = "n";
      TRACEFS_AUTOMOUNT_DEPRECATED = "n";
      TRACER_MAX_TRACE = "n";
      TRACER_SNAPSHOT = "n";
      TRACE_CLOCK = "n";
      TRACE_GPU_MEM = "n";
      TRACE_IRQFLAGS_NMI_SUPPORT = "n";
      TRACE_IRQFLAGS_SUPPORT = "n";
      TRACING = "n";
      USER_STACKTRACE_SUPPORT = "n";
    };
  };
}

{
  kernel.config = rec {
    commonfreq = {
      HZ_PERIODIC = "n";
      NO_HZ = "y";
      NO_HZ_COMMON = "y";
      PREEMPT_LAZY = "n";
    };

    lowfreq = {
      HZ = "250";
      NR_CPUS = "8";

      INPUT_JOYSTICK = "n";
      INPUT_TABLET = "n";
      INPUT_TOUCHSCREEN = "n";
      INPUT_UINPUT = "n";

      HZ_250 = "y";
      NO_HZ_IDLE = "y";

      PREEMPT_NONE = "y";
      PREEMPT_NONE_BUILD = "y";

      HZ_1000 = "n";
      NO_HZ_FULL = "n";
      NTSYNC = "n";
      PREEMPT = "n";
      PREEMPT_DYNAMIC = "n";
      PREEMPTION = "n";
      PREEMPT_VOLUNTARY = "n";

      SND = "n";
    }
    // commonfreq;

    highfreq = {
      HZ = "1000";
      NR_CPUS = "32";

      ANDROID_BINDERFS = "y";
      ANDROID_BINDER_IPC = "y";
      INPUT_UINPUT = "y";

      HZ_1000 = "y";
      NO_HZ_FULL = "y";
      NO_HZ_FULL_NODEF = "y";
      NTSYNC = "y";

      PREEMPT_BUILD = "y";
      PREEMPTION = "y";
      PREEMPT = "y";
      PREEMPT_COUNT = "y";
      PREEMPT_DYNAMIC = "y";
      CACHY = "y";
      SCHED_BORE = "y";

      NO_HZ_IDLE = "n";
      PREEMPT_NONE = "n";
      PREEMPT_VOLUNTARY = "n";
    }
    // commonfreq;
  };
}

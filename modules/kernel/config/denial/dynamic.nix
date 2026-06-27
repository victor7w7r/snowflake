{ kernel, ... }:
{
  kernel.config.denial.dynamic = config: [
    (kernel.lib.dynamic-denial {
      inherit config;
      attr = "BATTERY";
    })
  ];
}

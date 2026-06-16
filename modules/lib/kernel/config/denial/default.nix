{ kernel, ... }:
{
  kernel.config.denial.all =
    with kernel.config.denial;
    (kernel.lib.utils.concat-config [
      crypto
      dev.all
      filesystems.all
      fuel.all
      general.all
      gpio.all
      hardware.all
      input.all
      mfd
      net.all
      sound
      sensors.all
      serial.all
      storage.all
      usb.all
      vendor
      wmi
    ]);
}

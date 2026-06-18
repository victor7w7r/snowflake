{ kernel, ... }:
{
  kernel.config.denial.all =
    with kernel.config.denial;
    (kernel.lib.concat-config [
      comm.all
      crypto
      dev.all
      filesystems.all
      general.all
      gpio.all
      hardware.all
      input.all
      mfd
      net.all
      sensors.all
      serial.all
      sound.all
      storage.all
      usb.all
      vendor
    ]);
}

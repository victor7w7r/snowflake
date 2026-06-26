{ kernel, ... }:
{
  kernel.config.denial.all = with kernel.config.denial; [
    comm.all
    common.all
    crypto
    hardware.all
    misc
    net.all
    net-hardware.all
    serial.all
    sound.all
    storage.all
    vendor.all
  ];
}

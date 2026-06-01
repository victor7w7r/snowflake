{
  den.aspects.initrd.nixos.boot = {
    consoleLogLevel = 4;
    modprobeConfig.enable = true;
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };
    extraModprobeConfig = ''
      blacklist iTCO_wdt
      blacklist joydev
      blacklist mousedev
      blacklist mac_hid
      blacklist intel_hid
    '';
    initrd = {
      checkJournalingFS = true;
      compressorArgs = [
        "-19"
        "--ultra"
        "-T0"
        "--check"
      ];
      network.enable = true;
      verbose = true;
    };
  };
}

{
  kernel.lib.denial.input = rec {

    all = keyboard // mouse // joystick;

    keyboard = {
      KEYBOARD_ADC = "n";
      KEYBOARD_ADP5588 = "n";
      KEYBOARD_APPLESPI = "n";
      KEYBOARD_QT1050 = "n";
      KEYBOARD_QT1070 = "n";
      KEYBOARD_QT2160 = "n";
      KEYBOARD_DLINK_DIR685 = "n";
      KEYBOARD_LKKBD = "n";
      KEYBOARD_GPIO = "n";
      KEYBOARD_GPIO_POLLED = "n";
      KEYBOARD_TCA8418 = "n";
      KEYBOARD_MATRIX = "n";
      KEYBOARD_LM8323 = "n";
      KEYBOARD_LM8333 = "n";
      KEYBOARD_MAX7359 = "n";
      KEYBOARD_MAX7360 = "n";
      KEYBOARD_MPR121 = "n";
      KEYBOARD_NEWTON = "n";
      KEYBOARD_OPENCORES = "n";
      KEYBOARD_PINEPHONE = "n";
      KEYBOARD_SAMSUNG = "n";
      KEYBOARD_STOWAWAY = "n";
      KEYBOARD_SUNKBD = "n";
      KEYBOARD_IQS62X = "n";
      KEYBOARD_TM2_TOUCHKEY = "n";
      KEYBOARD_XTKBD = "n";
      KEYBOARD_MTK_PMIC = "n";
      KEYBOARD_CYPRESS_SF = "n";
    };

    mouse = {
      MOUSE_SERIAL = "n";
      MOUSE_APPLETOUCH = "n";
      MOUSE_BCM5974 = "n";
      MOUSE_CYAPA = "n";
      MOUSE_ELAN_I2C = "n";
      MOUSE_ELAN_I2C_I2C = "n";
      MOUSE_ELAN_I2C_SMBUS = "n";
      MOUSE_VSXXXAA = "n";
      MOUSE_GPIO = "n";
      MOUSE_SYNAPTICS_I2C = "n";
      MOUSE_SYNAPTICS_USB = "n";
    };

    joystick = {
      JOYSTICK_ANALOG = "n";
      JOYSTICK_A3D = "n";
      JOYSTICK_ADC = "n";
      JOYSTICK_ADI = "n";
      JOYSTICK_COBRA = "n";
      JOYSTICK_GF2K = "n";
      JOYSTICK_GRIP = "n";
      JOYSTICK_GRIP_MP = "n";
      JOYSTICK_GUILLEMOT = "n";
      JOYSTICK_INTERACT = "n";
      JOYSTICK_SIDEWINDER = "n";
      JOYSTICK_TMDC = "n";
      JOYSTICK_IFORCE = "n";
      JOYSTICK_IFORCE_USB = "n";
      JOYSTICK_IFORCE_232 = "n";
      JOYSTICK_WARRIOR = "n";
      JOYSTICK_MAGELLAN = "n";
      JOYSTICK_SPACEORB = "n";
      JOYSTICK_SPACEBALL = "n";
      JOYSTICK_STINGER = "n";
      JOYSTICK_TWIDJOY = "n";
      JOYSTICK_ZHENHUA = "n";
      JOYSTICK_AS5011 = "n";
      JOYSTICK_JOYDUMP = "n";
      JOYSTICK_XPAD = "n";
      JOYSTICK_XPAD_FF = "n";
      JOYSTICK_XPAD_LEDS = "n";
      JOYSTICK_PSXPAD_SPI = "n";
      JOYSTICK_PSXPAD_SPI_FF = "n";
      JOYSTICK_PXRC = "n";
      JOYSTICK_QWIIC = "n";
      JOYSTICK_FSIA6B = "n";
      JOYSTICK_SENSEHAT = "n";
      JOYSTICK_SEESAW = "n";
    };
  };
}

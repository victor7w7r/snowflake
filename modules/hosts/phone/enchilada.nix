{ phone, ... }:
{
  den = {
    hosts.aarch64-linux.phone-enchilada = {
      hostName = "v7w7r-enchilada";
      users.victor7w7r = { };
    };

    aspects.phone-enchilada = {
      includes = [ phone.common ];

      nixos = {
        zramSwap = {
          enable = true;
          algorithm = "zstd";
          memoryPercent = 60;
          priority = 100;
        };

        mobile = {
          system.android.device_name = "OnePlus6";
          device = {
            name = "oneplus-enchilada";
            supportLevel = "supported";
            identity.name = "OnePlus 6";
          };
          hardware.screen.height = 2280;
        };
      };
    };
  };
}

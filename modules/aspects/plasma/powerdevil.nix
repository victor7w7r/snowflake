{ hosts, lib, ... }:
{
  den.aspects.plasma.provides.powerdevil = {
    powerdevil.homeManager.programs.plasma.powerdevil = {
      general.pausePlayersOnSuspend = true;
      batteryLevels = {
        criticalAction = "hibernate";
        criticalLevel = 5;
        lowLevel = 10;
      };
      AC = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 3600;
        };
        turnOffDisplay = {
          idleTimeout = 180;
          idleTimeoutWhenLocked = 40;
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 120;
        };
        powerButtonAction = "sleep";
        whenLaptopLidClosed = "sleep";
      };
      battery = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 300;
        };
        turnOffDisplay = {
          idleTimeout = 60;
          idleTimeoutWhenLocked = 20;
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 45;
        };
        powerButtonAction = "sleep";
        whenLaptopLidClosed = "sleep";
      };
      lowBattery = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 60;
        };
        turnOffDisplay = {
          idleTimeout = 30;
          idleTimeoutWhenLocked = "immediately";
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 25;
        };
        powerButtonAction = "hibernate";
        whenLaptopLidClosed = "sleep";
      };
    };
  };
  provides = lib.genAttrs hosts.main (_: {
    homeManager.programs.plasma.powerdevil.AC = {
      autoSuspend.idleTimeout = 10800;
      turnOffDisplay.idleTimeout = 3600;
      dimDisplay.idleTimeout = 300;
    };
  });
}

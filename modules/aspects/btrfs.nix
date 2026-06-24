{
  den.aspects.btrfs = {
    services.btrfs = {
      autoScrub.enable = true;
    };
    napper = {
      snapshotRootOnBoot = true;
      persistentTimer = true;
    };
  };
}

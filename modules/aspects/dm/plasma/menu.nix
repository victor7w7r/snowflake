{ self, ... }: {
  den.aspects.plasma.menu.provides.to-users.homeManager =
    {
      config,
      lib,
      isPhone,
      ...
    }:
    lib.optionalAttrs (!isPhone) {
      home.activation.kmenuedit-menu = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        f="${config.xdg.configHome}/menus/applications-kmenuedit.menu"
        if [ ! -e "$f" ]; then
          $DRY_RUN_CMD install -Dm644 ${self}/modules/aspects/dm/plasma/applications-kmenuedit.menu "$f"
        fi
      '';
    };
}

{
  den.aspects.plasma.menu.provides.to-users.homeManager =
    { lib, isPhone, ... }:
    lib.optionalAttrs (!isPhone) {
      home.activation.kmenuedit-menu = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        CONFIG_DIR="$HOME/.config/menus"
        FILEMENU="$CONFIG_DIR/applications-kmenuedit.menu"

        if [ -f "$FILEMENU" ]; then
          exit 0
        fi

        cp ${./applications-kmenuedit.menu} "$FILEMENU"
      '';
    };
}

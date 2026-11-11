{ self, ... }: {
  den.aspects.plasma.menu.provides.to-users.homeManager =
    {
      lib,
      isPhone,
      ...
    }:
    lib.optionalAttrs (!isPhone) {
      home.activation.kmenuedit-menu = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        conf_dir="$HOME/.config/menus"
        f="$conf_dir/applications-kmenuedit.menu"
        mkdir -p "$conf_dir"

        if [ ! -e "$f" ]; then
          install -Dm644 ${self}/modules/aspects/dm/plasma/applications-kmenuedit.menu "$f"
        fi
      '';
    };
}

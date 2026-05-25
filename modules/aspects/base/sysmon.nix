{
  den.aspects.base.provides.sysmon = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          fatrace
          kmon
          lazyjournal
          lnav
          pik
          s-tui
          systemctl-tui
          sysz
          watchexec
          zps
          #nvtopPackages.full
          #(pkgs.callPackage ./custom/journalview.nix { })
          #https://github.com/jasonwitty/socktop
          #https://github.com/XhuyZ/lazysys
          #pcp
          #uv pip install tiptop
        ];
      };

    homeManager.programs = {
      bottom.enable = true;
      btop = {
        enable = true;
        settings = {
          color_theme = "dracula";
          theme_background = false;
          update_ms = 500;
        };
      };
      hwatch.enable = true;
    };
  };
}

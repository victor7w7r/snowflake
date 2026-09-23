{
  den.default.os.programs.nixvim.plugins.lualine = {
    enable = true;
    settings.options = {
      theme = "nightfly";
      globalstatus = true;
      disabled_filetypes = [
        "dashboard"
        "lazy"
        "alpha"
      ];
      sections = {
        lualine_a = [
          {
            __unkeyed = "mode";
            icon = "";
          }
        ];
        lualine_b = [
          {
            __unkeyed = "branch";
            icon = "";
          }
          "diff"
        ];
        lualine_c = [
          {
            __unkeyed = "filename";
            path = 1;
            symbols = {
              modified = "";
              readonly = "";
            };
          }
        ];
        lualine_x = [
          "diagnostics"
          "encoding"
          {
            __unkeyed = "filetype";
            icon_only = true;
          }
        ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
    };
  };
}

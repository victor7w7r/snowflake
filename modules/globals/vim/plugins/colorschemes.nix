{
  den.default.os.programs.nixvim.colorschemes.tokyonight = {
    enable = true;
    settings = {
      style = "night";
      transparent = true;
      terminal_colors = true;
      dim_inactive = false;
      lualine_bold = true;
      on_colors = "function(colors) colors.comment = '#b4bcd0' end";
      styles = {
        comments.italic = true;
        keywords.italic = true;
        functions.bold = true;
        sidebars = "transparent";
        floats = "transparent";
      };
    };
  };
}

{
  den.default.os.programs.nixvim.plugins = {
    baleia.enable = true;
    better-escape.enable = true;
    colorizer.enable = true;
    ccc.enable = true;
    endec.enable = true;

    flash = {
      enable = true;
      settings = { };
    };

    hardtime.enable = true;

    image = {
      enable = true;
      settings = {
        integrations.neorg.enabled = true;
        editor_only_render_when_focused = true;
        tmux_show_only_in_active_window = true;
      };
    };

    inc-rename.enable = true;
    indent-blankline = {
      enable = true;
      settings = {
        indent = {
          smart_indent_cap = true;
          char = " ";
        };
        scope = {
          enabled = true;
          char = "│";
        };
      };
    };

    illuminate.enable = true;

    persistence = {
      enable = true;
      lazyLoad.settings.event = "BufReadPre";
    };

    rainbow-delimiters = {
      enable = true;
      settings = {
        strategy = {
          "".__raw = ''
            function(bufnr)
              if vim.api.nvim_buf_line_count(bufnr) > 5000 then
                return nil
              end
              return require("rainbow-delimiters").strategy.global
            end
          '';
        };
        query = {
          "" = "rainbow-delimiters";
          lua = "rainbow-blocks";
        };
        highlight = [
          "RainbowDelimiterRed"
          "RainbowDelimiterYellow"
          "RainbowDelimiterBlue"
          "RainbowDelimiterOrange"
          "RainbowDelimiterGreen"
          "RainbowDelimiterViolet"
          "RainbowDelimiterCyan"
        ];
      };
    };

    todo-comments = {
      enable = true;
      settings = {
        signs = true;
      };
    };

    undotree = {
      enable = true;
      settings = {
        autoOpenDiff = true;
        focusOnToggle = true;
      };
    };

    yanky.enable = true;
  };
}

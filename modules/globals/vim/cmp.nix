{
  den.default.os.programs.nixvim.plugins =
    (
      { ... }@args:
      {
        enable = true;
        lazyLoad.settings.event = [
          "InsertEnter"
          "CmdlineEnter"
        ];
      }
      // (removeAttrs args [ "enable" ])
    )
    |> (insertPlugin: {
      blink-cmp-dictionary = insertPlugin { };
      blink-emoji = insertPlugin { };
      blink-ripgrep = insertPlugin { };
      blink-pairs = insertPlugin { };
      blink-cmp-words = insertPlugin { };
      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
        lazyLoad.settings.event = [
          "InsertEnter"
          "CmdlineEnter"
        ];
        settings = {
          signature = {
            enabled = true;
          };

          appearance = {
            nerd_font_variant = "mono";
          };

          keymap = {
            preset = "default";
            "<CR>" = [
              "accept"
              "fallback"
            ];
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
          };

          snippets.preset = "default";

          completion = {
            accept.auto_brackets.enabled = true;
            menu = {
              border = "rounded";
              draw.treesitter = [ "lsp" ];
            };
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 200;
              window.border = "rounded";
            };
            ghost_text.enabled = false;
          };

          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];

          cmdline = {
            enabled = true;
            keymap = {
              preset = "cmdline";
              "<Right>" = false;
              "<Left>" = false;
            };
            completion = {
              list.selection.preselect = false;
              menu.auto_show.__raw = ''
                function(ctx)
                  return vim.fn.getcmdtype() == ":"
                end
              '';
              ghost_text.enabled = true;
            };
          };
        };
      };
      friendly-snippets = insertPlugin { };
    });
}

{
  den.default.os.programs.nixvim.plugins =
    { ... }@args:
    {
      enable = true;
      lazyLoad.settings.event = [
        "InsertEnter"
        "CmdlineEnter"
      ];
    }
    // (removeAttrs args [ "enable" ])
    |> (insertPlugin: {
      blink-cmp-dictionary.enable = insertPlugin { };
      blink-cmp-git.enable = insertPlugin { };
      blink-emoji.enable = insertPlugin { };
      blink-indent.enable = insertPlugin { };
      blink-ripgrep.enable = insertPlugin { };
      blink-pairs.enable = insertPlugin { };
      blink-cmp-words.enable = insertPlugin { };
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
            kind_icons = {
              Text = "󰉿";
              Method = "";
              Function = "󰊕";
              Constructor = "󰒓";

              Field = "󰜢";
              Variable = "󰆦";
              Property = "󰖷";

              Class = "󱡠";
              Interface = "󱡠";
              Struct = "󱡠";
              Module = "󰅩";

              Unit = "󰪚";
              Value = "󰦨";
              Enum = "󰦨";
              EnumMember = "󰦨";

              Keyword = "󰻾";
              Constant = "󰏿";

              Snippet = "󱄽";
              Color = "󰏘";
              File = "󰈔";
              Reference = "󰬲";
              Folder = "󰉋";
              Event = "󱐋";
              Operator = "󰪚";
              TypeParameter = "󰬛";
              Error = "󰏭";
              Warning = "󰏯";
              Information = "󰏮";
              Hint = "󰏭";

              Emoji = "🤶";
            };
          };

          keymap = {
            preset = "enter";
            "<C-y>" = [ "select_and_accept" ];
            "<Tab>" = [
              "snippet_forward"
              "fallback"
            ];
            "<S-Tab>" = [
              "snippet_backward"
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
      friendly-snippets.enable = insertPlugin { };
    });
}

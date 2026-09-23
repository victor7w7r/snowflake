{
  den.default.os.programs.nixvim.plugins = {
    friendly-snippets.enable = true;
    blink-copilot.enable = true;
    blink-cmp-copilot.enable = true;
    blink-cmp-dictionary.enable = true;
    blink-cmp-git.enable = true;
    blink-emoji.enable = true;
    blink-ripgrep.enable = true;
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;
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
  };
}

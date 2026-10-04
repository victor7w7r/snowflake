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
      blink-cmp-words = insertPlugin { };
      blink-emoji = insertPlugin { };
      blink-ripgrep = insertPlugin { };
      luasnip = insertPlugin { };

      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
        lazyLoad.settings.event = [
          "InsertEnter"
          "CmdlineEnter"
        ];
        settings = {
          appearance.nerd_font_variant = "mono";
          snippets.preset = "luasnip";

          sources = {
            providers = {
              buffer.score_offset = 10;

              dictionary = {
                module = "blink-cmp-dictionary";
                name = "Dict";
                score_offset = 100;
                min_keyword_length = 3;
                opts = {
                  dictionary_search_threshold = 3;
                  score_offset = 0;
                  definition_pointers = [
                    "!"
                    "&"
                    "^"
                  ];
                };
              };

              emoji = {
                module = "blink-emoji";
                name = "Emoji";
                score_offset = 15;
                opts.insert = true;
              };

              lsp.score_offset = 30;

              ripgrep = {
                async = true;
                module = "blink-ripgrep";
                name = "Ripgrep";
                score_offset = 0;
                opts = {
                  prefix_min_len = 3;
                  context_size = 5;
                  max_filesize = "1M";
                  project_root_marker = ".git";
                  project_root_fallback = true;
                  search_casing = "--ignore-case";
                  additional_rg_options = { };
                  fallback_to_regex_highlighting = true;
                  ignore_paths = { };
                  additional_paths = { };
                  debug = false;
                };
              };

              path.score_offset = 40;
              snippets = {
                score_offset = 20;
                opts.use_label_description = true;
              };

              thesaurus = {
                name = "blink-cmp-words";
                module = "blink-cmp-words.thesaurus";
                opts = {
                  score_offset = 0;
                  definition_pointers = [
                    "!"
                    "&"
                    "^"
                  ];
                  similarity_pointers = [
                    "&"
                    "^"
                  ];
                  similarity_depth = 2;
                };
              };
            };
            per_filetype = {
              text = [
                "dictionary"
                "emoji"
              ];
              markdown = [
                "thesaurus"
                "emoji"
              ];
            };
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
              "ripgrep"
              "dictionary"
              "emoji"
            ];
          };

          keymap = {
            preset = "super-tab";
            "<CR>" = [
              "select_and_accept"
              "fallback"
            ];
          };

          fuzzy.sorts = [
            "exact"
            "score"
            "sort_text"
          ];

          completion = {
            accept.auto_brackets.enabled = true;
            keyword.range = "full";
            menu = {
              border = "rounded";
              draw.columns = [
                { __raw = "{'kind_icon', 'label', 'label_description', gap = 1}"; }
                { __raw = "{'kind', 'source_name'}"; }
              ];
            };
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 200;
              window.border = "rounded";
            };
            ghost_text.enabled = false;
          };

          cmdline = {
            enabled = true;
            keymap = {
              preset = "super-tab";
              "<CR>" = [
                "select_and_accept"
                "fallback"
              ];
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
    });
}

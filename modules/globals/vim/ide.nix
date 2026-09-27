{
  den.default.os.programs.nixvim.plugins = {
    aerial.enable = true;
    actions-preview.enable = true;
    arrow.enable = true;

    auto-save = {
      enable = true;
      settings.enabled = true;
    };

    compiler.enable = true;

    colorful-menu = {
      enable = true;
      settings = {
        ls = {
          lua_ls.arguments_hl = "@comment";
          ts_ls.extra_info_hl = "@comment";
        };
        fallback_highlight = "@variable";
        max_width = 60;
      };
    };

    dbee.enable = true;
    dial.enable = true;
    fastaction.enable = true;

    glance = {
      enable = true;
      settings = {
        border.enable = true;
      };
    };

    goto-preview.enable = true;

    grug-far = {
      enable = true;
      settings.headerMaxWidth = 80;
      lazyLoad.settings = {
        cmd = "GrugFar";
        keys = [
          {
            __unkeyed-1 = "<leader>sr";
            mode = [
              "n"
              "x"
            ];
            __unkeyed-2.__raw = ''
              function()
                local grug = require("grug-far")
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                grug.open({
                  transient = true,
                  prefills = {
                    filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                  },
                })
              end
            '';
            desc = "Search and Replace";
          }
        ];
      };
    };

    neo-tree = {
      enable = true;
      lazyLoad.settings.cmd = "Neotree";
      settings = {
        enableDiagnostics = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
        enableRefreshOnWrite = true;
        close_if_last_window = true;
        window = {
          width = 25;
          position = "left";
        };
        default_component_configs.icon = {
          folder_closed = "󰉋";
          folder_open = "󰝰";
          folder_empty = "󰉖";
          default = "󰈙";
        };
        filesystem = {
          /*
            window.mappings = {
              "gA" = "git_add_all";
              "ga" = "git_add_file";
              "gu" = "git_unstage_file";
            };
            group_empty_dirs = true;
            follow_current_file.enabled = true;
            use_libuv_file_watcher = true
          */
          filtered_items = {
            hide_dotfiles = false;
            hide_by_name = [ ".git" ];
          };
        };
      };
    };

    nvim-lightbulb.enable = true;

    persistence = {
      enable = true;
      settings.options = [
        "buffers"
        "curdir"
        "tabpages"
        "winsize"
      ];
    };

    project-nvim = {
      enable = true;
      enableTelescope = true;
      settings = {
        patterns = [
          ".git"
        ];
        lsp.enabled = true;
        show_hidden = true;
        silent_chdir = false;
        manual_mode = false;
      };
    };

    rest.enable = true;
    toggler.enable = true;

    treesj = {
      enable = true;
      settings.use_default_keymaps = false;
    };

    trouble = {
      enable = true;
      settings.modes.lsp.win.position = "right";
    };
  };
}

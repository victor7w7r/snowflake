{
  den.default.os.programs.nixvim.plugins = {
    aerial = {
      enable = true;
      lazyLoad.settings.cmd = "AerialToggle";
    };

    actions-preview = {
      enable = true;
      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<leader>ca";
          __unkeyed-2.__raw = ''
            function()
              require('actions-preview').code_actions()
            end
          '';
          desc = "Code actions preview";
        }
      ];
    };

    arrow = {
      enable = true;
      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<cr>";
          desc = "Open Arrow Bookmarks";
        }
      ];
    };

    auto-save = {
      enable = true;
      lazyLoad.settings.event = [
        "InsertLeave"
        "TextChanged"
      ];
      settings = {
        enabled = true;
        debounce_delay = 1000;
        write_all_buffers = false;
      };
    };

    compiler = {
      enable = true;
      lazyLoad.settings.cmd = [
        "CompilerOpen"
        "CompilerRedo"
        "CompilerStop"
        "CompilerToggleResults"
      ];
    };

    colorful-menu = {
      enable = true;
      lazyLoad.settings.event = "InsertEnter";
      settings = {
        ls = {
          lua_ls.arguments_hl = "@comment";
          ts_ls.extra_info_hl = "@comment";
        };
        fallback_highlight = "@variable";
        max_width = 60;
      };
    };

    dbee = {
      enable = true;
      lazyLoad.settings.cmd = "Dbee";
    };

    dial = {
      enable = true;
      lazyLoad.settings.event = "InsertEnter";
    };

    fastaction = {
      enable = true;
      lazyLoad.settings.event = "LspAttach";
    };

    glance = {
      enable = true;
      lazyLoad.settings.cmd = "Glance";
      settings = {
        border.enable = true;
      };
    };

    goto-preview = {
      enable = true;
      lazyLoad.settings.event = "LspAttach";
    };

    grug-far = {
      enable = true;
      settings.headerMaxWidth = 80;
      lazyLoad.settings.cmd = "GrugFar";
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

    nvim-lightbulb = {
      enable = true;
      lazyLoad.settings.event = "LspAttach";
    };

    persistence = {
      enable = true;
      lazyLoad.settings.event = "BufReadPre";
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
      lazyLoad.settings.event = "DeferredUIEnter";
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

    rest = {
      enable = true;
      lazyLoad.settings.ft = ["http" "rest"];
    };

    toggler = {
      enable = true;
      lazyLoad.settings.event = "InsertEnter";
    };

    treesj = {
      enable = true;
      lazyLoad.settings.event = "LspAttach";
      settings.use_default_keymaps = false;
    };

    trouble = {
      enable = true;
      lazyLoad.settings.cmd = "Trouble";
      settings.modes.lsp.win.position = "right";
    };
  };
}

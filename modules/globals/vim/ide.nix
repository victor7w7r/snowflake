{
  den.default.os.programs.nixvim.plugins = {
    aerial = {
      enable = true;
      lazyLoad.settings.cmd = "AerialToggle";
      settings = {
        show_guides = true;
        layout = {
          default_direction = "prefer_left";
          placement = "edge";
          width = 20;
        };
      };
    };

    actions-preview = {
      enable = true;
      lazyLoad.settings.event = "LspAttach";
      settings = {
        backend = "snacks";
        diff = {
          algorithm = "patience";
          ignore_whitespace = true;
        };
      };
    };

    arrow.enable = true;

    auto-save = {
      enable = true;
      lazyLoad.settings.event = [
        "InsertLeave"
        "TextChanged"
      ];
      settings = {
        enabled = true;
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

    telescope = {
      lazyLoad.settings.event = "BufReadPre";
      enable = true;
    };

    overseer = {
      enable = true;
      lazyLoad.settings.cmd = [
        "CompilerOpen"
        "CompilerRedo"
        "CompilerStop"
        "CompilerToggleResults"
      ];
      settings.task_list = {
        direction = "bottom";
        min_height = 25;
        max_height = 25;
        default_detail = 1;
      };
    };

    dbee = {
      enable = true;
      lazyLoad.settings.cmd = "Dbee";
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
        closeIfLastWindow = true;
        buffers.bindToCwd = false;
        popup_border_style = "rounded";

        sources = [
          "filesystem"
          "buffers"
          "git_status"
          "document_symbols"
        ];

        source_selector = {
          winbar = true;
          statusline = false;
          sources = [
            {
              source = "filesystem";
              display_name = " 󰉓 Files";
            }
            {
              source = "buffers";
              display_name = " 󰈚 Buffers";
            }
            {
              source = "git_status";
              display_name = " 󰊢 Git";
            }
            {
              source = "document_symbols";
              display_name = "  Symbols";
            }
          ];
        };

        window = {
          width = 35;
          height = 15;
          autoExpandWidth = false;
          mappings = {
            "<space>" = "none";
          };
        };
        default_component_configs.icon = {
          folder_closed = "󰉋";
          folder_open = "󰝰";
          folder_empty = "󰉖";
          default = "󰈙";
        };
        filesystem = {
          group_empty_dirs = true;
          follow_current_file = {
            enabled = true;
            leave_dirs_open = false;
          };
          filtered_items = {
            hide_dotfiles = false;
            always_show = [
              "node_modules"
              "dist"
              "'[A-Z]*'"
            ];
            visible = true;
          };
          window.mappings = {
            "gA" = "git_add_all";
            "ga" = "git_add_file";
            "gu" = "git_unstage_file";
          };
        };
      };
    };

    nui = {
      enable = true;
      lazyLoad.settings.event = [
        "BufReadPost"
        "BufWritePost"
        "BufNewFile"
      ];
    };

    nvim-lightbulb = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings = {
        autocmd.enabled = true;
        virtual_text.enabled = false;
        number.enabled = true;
      };
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

    toggler = {
      enable = true;
      lazyLoad.settings.event = "InsertEnter";
    };

    trouble = {
      enable = true;
      lazyLoad.settings.cmd = "Trouble";
      settings.modes.lsp.win.position = "right";
    };
  };
}

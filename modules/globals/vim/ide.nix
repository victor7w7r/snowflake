{
  den.default.os.programs.nixvim.plugins = {
    aerial.enable = true;
    actions-preview.enable = true;
    arrow.enable = true;
    autoclose.enable = true;

    auto-save = {
      enable = true;
      settings.enabled = true;
    };

    comment-box.enable = true;
    comment.enable = true;
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

    dropbar = {
      enable = true;
      settings.bar.update_events.buf = [
        "FileChangedShellPost"
        "TextChanged"
        "ModeChanged"
      ];
    };

    fastaction.enable = true;
    lsp-progress.enable = true;

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

    navbuddy.enable = true;

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
          position = "left";
          width = 30;
        };
        default_component_configs.icon = {
          folder_closed = "󰉋";
          folder_open = "󰝰";
          folder_empty = "󰉖";
          default = "󰈙";
        };
        filesystem = {
          bind_to_cwd = true;
          cwd_target.sidebar = "tab";
          follow_current_file.enabled = true;
          filtered_items.visible = true;
        };
      };
    };

    nvim-autopairs = {
      enable = true;
      settings = {
        disable_filetype = [
          "TelescopePrompt"
          "vim"
        ];
        check_ts = true;
        enable_check_bracket_line = false;
        fast_wrap = {
          enable = true;
          map = "<M-e>";
          chars = [
            "{"
            "["
            "("
            "\""
            "'"
            "`"
          ];
        };
      };
    };

    nvim-lightbulb.enable = true;

    nvim-ufo = {
      enable = true;
      lazyLoad.settings.event = "BufEnter";
    };

    project-nvim = {
      enable = true;
      enableTelescope = true;
      settings = {
        patterns = [
          ">repositories"
          /*".git"
          "package.json"
          "flake.nix"
          "gradlew"
          "Cargo.toml"*/
        ];
        lsp.enabled = true;
        use_git = true;
        custom_projects.__raw = ''
          (function()
            local expand = require("project.util").strip_slash
            local repositories = expand("~/repositories")
            local projects = {}

            if vim.fn.isdirectory(repositories) == 1 then
              for _, path in ipairs(vim.fn.glob(repositories .. "/*", false, true)) do
                if vim.fn.isdirectory(path) == 1 then
                  table.insert(projects, {
                    path = expand(path),
                    name = vim.fn.fnamemodify(path, ":t"),
                  })
                end
              end
            end

            return projects
          end)()
        '';

        on_attach.__raw = ''
          function(dir, _, _)
            local tab = vim.api.nvim_get_current_tabpage()
            local ok, current_root = pcall(vim.api.nvim_tabpage_get_var, tab, "nixvim_project_ui_root")
            if ok and current_root == dir then
              return
            end
            vim.api.nvim_tabpage_set_var(tab, "nixvim_project_ui_root", dir)

            vim.schedule(function()
              if not vim.api.nvim_tabpage_is_valid(tab) or vim.api.nvim_get_current_tabpage() ~= tab then
                return
              end
              vim.cmd("Neotree filesystem show reveal_force_cwd")
              require("mini.map").open()
            end)
          end
        '';
        show_hidden = true;
        silent_chdir = false;
      };
    };

    rest.enable = true;
    toggler.enable = true;

    treesj = {
      enable = true;
      autoLoad = true;
    };

    trouble = {
      enable = true;
      lazyLoad.settings.cmd = "Trouble";
      settings.modes.lsp.win.position = "right";
    };

    ts-autotag = {
      enable = true;
      settings.opts = {
        enable_close = true;
        enable_rename = true;
        enable_close_on_slash = false;
        per_filetype.html.enable_close = false;
      };
    };
  };
}

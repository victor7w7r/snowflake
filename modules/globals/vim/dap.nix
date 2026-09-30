{
  den.default.os = { lib, pkgs, ... }: {
    programs.nixvim.plugins = {
      dap = {
        enable = true;
        lazyLoad.settings = {
          cmd = [
            "DapToggleBreakpoint"
            "DapContinue"
            "DapStepInto"
            "DapStepOut"
            "DapStepOver"
            "DapToggleRepl"
            "DapTerminate"
          ];
        };
        signs = {
          dapBreakpoint = {
            text = "●";
            texthl = "DapBreakpoint";
          };
          dapBreakpointCondition = {
            text = "◆";
            texthl = "DapBreakpointCondition";
          };
          dapLogPoint = {
            text = "◆";
            texthl = "DapLogPoint";
          };
          dapStopped = {
            text = "→";
            texthl = "DapStopped";
            linehl = "DapStoppedLine";
          };
          dapBreakpointRejected = {
            text = "○";
            texthl = "DapBreakpointRejected";
          };
        };
        adapters.servers =
          {
            host = "localhost";
            port = "\${port}";
            executable = {
              command = lib.getExe pkgs.vscode-js-debug;
              args = [ "\${port}" ];
            };
          }
          |> (server: {
            pwa-node = server;
            pwa-chrome = server;
          });

        configurations =
          [
            {
              type = "pwa-node";
              request = "launch";
              name = "Astro: Dev Server";
              runtimeExecutable = lib.getExe pkgs.nodejs;
              runtimeArgs = [
                "--inspect"
                "./node_modules/astro/astro.js"
                "dev"
              ];
              console = "integratedTerminal";
              cwd = "\${workspaceFolder}";
              sourceMaps = true;
              skipFiles = [ "<node_internals>/**" ];
              resolveSourceMapLocations = [
                "\${workspaceFolder}/**"
                "!**/node_modules/**"
              ];
            }
            {
              type = "pwa-chrome";
              request = "launch";
              name = "Astro: Launch Chrome (Client)";
              url = "http://localhost:4321";
              webRoot = "\${workspaceFolder}";
              sourceMaps = true;
              userDataDir = false;
            }
            {
              type = "pwa-node";
              request = "launch";
              name = "Launch file";
              program = "\${file}";
              cwd = "\${workspaceFolder}";
            }
            {
              type = "pwa-node";
              request = "attach";
              name = "Attach to Process (Pick)";
              processId.__raw = ''require("dap.utils").pick_process'';
              cwd = "\${workspaceFolder}";
            }
            {
              type = "pwa-node";
              request = "launch";
              name = "Debug Server (Production Build)";
              skipFiles = [ "<node_internals>/**" ];
              program.__raw = "vim.fn.getcwd() .. '/dist/server/entry.mjs'";
              console = "integratedTerminal";
            }
          ]
          |> (js-config: {
            javascript = js-config;
            javascriptreact = js-config;
            typescript = js-config;
            typescriptreact = js-config;
            astro = js-config;
          });
      };

      dap-disasm = {
        enable = true;
        lazyLoad.settings.before.__raw = "function() require('lz.n').trigger_load('nvim-dap') end";
        settings.dapview_register = true;
      };

      dap-lldb = {
        enable = true;
        lazyLoad.settings.before.__raw = "function() require('lz.n').trigger_load('nvim-dap') end";
        settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter}/bin/codelldb";
      };

      dap-ui = {
        enable = true;

        lazyLoad.settings.before.__raw = ''
          function()
            require('lz.n').trigger_load('nvim-dap', {})
            require('lz.n').trigger_load('nvim-dap-virtual-text', {})
          end
        '';

        settings = {
          floating = {
            max_height = null;
            max_width = null;
            border = "rounded";
            mappings.close = [
              "<ESC>"
              "q"
            ];
          };

          icons = {
            expanded = "▾";
            collapsed = "▸";
            current_frame = "*";
          };

          controls.icons = {
            pause = "⏸";
            play = "▶";
            step_into = "⏎";
            step_over = "⏭";
            step_out = "⏮";
            step_back = "b";
            run_last = "▶▶";
            terminate = "⏹";
            disconnect = "⏏";
          };

          keys = [
            {
              __unkeyed-1 = "<leader>du";
              __unkeyed-2.__raw = ''
                function()
                  require('dap.ext.vscode').load_launchjs(nil, {})
                  require("dapui").toggle()
                end
              '';
              desc = "Toggle Debugger UI";
            }
          ];
        };
      };

      dap-virtual-text = {
        enable = true;
        lazyLoad.settings.before.__raw = "function() require('lz.n').trigger_load('nvim-dap') end";
        settings = {
          all_frames = true;
          all_references = true;
          commented = false;
          highlight_changed_variables = true;
          highlight_new_as_changed = false;
          only_first_definition = true;
          show_stop_reason = true;
        };
      };
    };
  };
}

{
  den.default.os.programs.nixvim.plugins = {
    dap = {
      enable = true;
      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<leader>dB";
          __unkeyed-2.__raw = ''function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end'';
          desc = "Breakpoint Condition";
        }
        {
          __unkeyed-1 = "<leader>db";
          __unkeyed-2.__raw = ''function() require("dap").toggle_breakpoint() end'';
          desc = "Toggle Breakpoint";
        }
        {
          __unkeyed-1 = "<leader>dc";
          __unkeyed-2.__raw = ''function() require("dap").continue() end'';
          desc = "Run/Continue";
        }
        {
          __unkeyed-1 = "<leader>da";
          __unkeyed-2.__raw = ''
            function()
              require("dap").continue({
                before = function(config)
                  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
                  local args_str = type(args) == "table" and table.concat(args, " ") or args
                  config = vim.deepcopy(config)
                  config.args = function()
                    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str))
                    if config.type and config.type == "java" then
                      return new_args
                    end
                    return require("dap.utils").splitstr(new_args)
                  end
                  return config
                end,
              })
            end
          '';
          desc = "Run with Args";
        }
        {
          __unkeyed-1 = "<leader>dC";
          __unkeyed-2.__raw = ''function() require("dap").run_to_cursor() end'';
          desc = "Run to Cursor";
        }
        {
          __unkeyed-1 = "<leader>dg";
          __unkeyed-2.__raw = ''function() require("dap").goto_() end'';
          desc = "Go to Line (No Execute)";
        }
        {
          __unkeyed-1 = "<leader>di";
          __unkeyed-2.__raw = ''function() require("dap").step_into() end'';
          desc = "Step Into";
        }
        {
          __unkeyed-1 = "<leader>dj";
          __unkeyed-2.__raw = ''function() require("dap").down() end'';
          desc = "Down";
        }
        {
          __unkeyed-1 = "<leader>dk";
          __unkeyed-2.__raw = ''function() require("dap").up() end'';
          desc = "Up";
        }
        {
          __unkeyed-1 = "<leader>dl";
          __unkeyed-2.__raw = ''function() require("dap").run_last() end'';
          desc = "Run Last";
        }
        {
          __unkeyed-1 = "<leader>do";
          __unkeyed-2.__raw = ''function() require("dap").step_out() end'';
          desc = "Step Out";
        }
        {
          __unkeyed-1 = "<leader>dO";
          __unkeyed-2.__raw = ''function() require("dap").step_over() end'';
          desc = "Step Over";
        }
        {
          __unkeyed-1 = "<leader>dP";
          __unkeyed-2.__raw = ''function() require("dap").pause() end'';
          desc = "Pause";
        }
        {
          __unkeyed-1 = "<leader>dr";
          __unkeyed-2.__raw = ''function() require("dap").repl.toggle() end'';
          desc = "Toggle REPL";
        }
        {
          __unkeyed-1 = "<leader>ds";
          __unkeyed-2.__raw = ''function() require("dap").session() end'';
          desc = "Session";
        }
        {
          __unkeyed-1 = "<leader>dt";
          __unkeyed-2.__raw = ''function() require("dap").terminate() end'';
          desc = "Terminate";
        }
        {
          __unkeyed-1 = "<leader>dw";
          __unkeyed-2.__raw = ''function() require("dap.ui.widgets").hover() end'';
          desc = "Widgets";
        }
        {
          __unkeyed-1 = "<leader>du";
          __unkeyed-2.__raw = ''function() require("dapui").toggle({}) end'';
          desc = "Dap UI";
        }
        {
          __unkeyed-1 = "<leader>de";
          mode = [
            "n"
            "x"
          ];
          __unkeyed-2.__raw = ''function() require("dapui").eval() end'';
          desc = "Eval";
        }
      ];
    };

    dap-disasm.enable = true;
    #dap-lldb.enable = true;

    dap-ui.enable = true;

    dap-virtual-text = {
      enable = true;
      lazyLoad.settings.lazy = true;
      settings = {
        icons = {
          expanded = "▾";
          collapsed = "▸";
          current_frame = "*";
        };

        controls = {
          icons = {
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
        };
      };
    };
  };
}

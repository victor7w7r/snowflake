{
  den.default.os = { pkgs, ... }: {
    programs.nixvim.plugins = {
      avante = {
        enable = true;
        lazyLoad.settings.cmd = [
          "AvanteAsk"
          "AvanteBuild"
          "AvanteChat"
          "AvanteEdit"
          "AvanteFocus"
          "AvanteRefresh"
          "AvanteSwitchProvider"
          "AvanteShowRepoMap"
          "AvanteToggle"
        ];
        settings = {
          provider = "copilot";
          providers.copilot = {
            model = "gpt-4.1";
          };
          hints.enabled = true;
          model = "gpt-4";
          window = {
            border = "rounded";
            wrapping = true;
          };
        };
      };

      blink-cmp-avante = {
        enable = true;
        lazyLoad.settings.event = [
          "InsertEnter"
          "CmdlineEnter"
        ];
      };

      copilot-lua = {
        enable = true;
        lazyLoad.settings = {
          cmd = "Copilot";
          event = "InsertEnter";
        };
        settings = {
          copilot_node_command = "${pkgs.nodejs}/bin/node";
          filetypes = {
            "." = false;
            cvs = false;
            gitrebase = false;
            help = false;
            hgcommit = false;
            json = true;
            markdown = true;
            svn = false;
            toml = true;
            yaml = true;

            nix = true;
            terraform = true;
            sh.__raw = ''
              function ()
                if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
                  return false
                end
                return true
              end
            '';

            javascript = true;
            python = true;
            typescript = true;
            "*" = false;
          };

          panel.enabled = false;

          suggestion = {
            enabled = true;
            auto_trigger = true;

            keymap = {
              accept = "<M-'>";
              accept_line = "<M-S-;>";
              accept_word = "<M-;>";
              dismiss = "<C-]>";
              next = "<M-]>";
              prev = "<M-[>";
            };
          };
        };
      };
    };
  };
}

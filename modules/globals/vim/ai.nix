{
  den.default.os = { lib, pkgs, ... }: {
    programs.nixvim = {
      plugins = {
        avante = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
          package = pkgs.vimPlugins.avante-nvim.overrideAttrs (oldAttrs: {
            postPatch = (oldAttrs.postPatch or "") + ''
              substituteInPlace lua/avante/providers/copilot.lua \
                --replace-fail '  --- hosts.json (copilot.lua), apps.json (copilot.vim)' \
                '  local db_path = Path:new(config_dir):joinpath("github-copilot", "auth.db")
                  if db_path:exists() and vim.fn.executable("sqlite3") == 1 then
                    local query = "SELECT CAST(token_ciphertext AS TEXT) FROM oauth_tokens LIMIT 1;"
                    local res = vim.fn.system({ "sqlite3", db_path:absolute(), query })
                    local token = vim.trim(res)
                    if vim.v.shell_error == 0 and #token > 0 then return token end
                  end

                  --- hosts.json (copilot.lua), apps.json (copilot.vim)'
            '';
          });
          settings = {
            auto_suggestions_provider = "copilot";
            provider = "copilot";
            providers.copilot.model = "gpt-4.1";
            hints.enabled = true;
            window = {
              border = "rounded";
              wrapping = true;
              input = {
                prefix = "❯ ";
              };
            };
          };
        };

        blink-cmp-avante = {
          enable = true;
          lazyLoad.settings.event = "InsertEnter";
        };

        blink-copilot = {
          enable = true;
          lazyLoad.settings.event = "InsertEnter";
        };

        blink-cmp.settings.sources = {
          providers = {
            avante = {
              module = "blink-cmp-avante";
              name = "Avante";
            };
            copilot = {
              async = true;
              module = "blink-copilot";
              name = "copilot";
              score_offset = 100;
              opts = {
                max_completions = 3;
                max_attempts = 4;
                kind = "Copilot";
                debounce = 750;
                auto_refresh = {
                  backward = true;
                  forward = true;
                };
              };
            };
          };
          default = lib.mkAfter [
            "avante"
            "copilot"
          ];
        };

        copilot-lua = {
          enable = true;
          lazyLoad.settings.event = "DeferredUIEnter";
          settings = {
            panel.enabled = false;
            suggestion.enabled = true;
          };
        };
      };
    };
  };
}

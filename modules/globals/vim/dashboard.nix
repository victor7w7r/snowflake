{
  den.default.os = { lib, ... }: {
    programs.nixvim.plugins.dashboard = {
      enable = true;
      luaConfig.post = ''
        vim.api.nvim_set_hl(0, "DashboardFooter", {
          fg = "#bb9af7",
          italic = true,
        })
      '';
      settings = {
        theme = "doom";
        config = {
          header = lib.generators.mkLuaInline ''
            vim.split([[
            .oPYo. .oPYo. .pPYo.   .oPYo.                       o   o                 .oPYo.   o              8  o          *
            8  .o8     `8 8        8    8                       8                     8        8              8             *
                8 .P`8   .oP` 8oPYo.   8      oPYo. .oPYo. .oPYo.  o8P o8 o    o .oPYo.   `Yooo.  o8P o    o .oPYo8 o8 .oPYo. .oPYo.
              8.d` 8    `b. 8`  `8   8      8  `` 8oooo8 .oooo8   8   8 Y.  .P 8oooo8       `8   8  8    8 8    8  8 8    8 Yb..
                8o`  8     :8 8.  .P   8    8 8     8.     8    8   8   8 `b..d` 8.            8   8  8    8 8    8  8 8    8   `Yb.
                `YooP` `YooP` `YooP`   `YooP` 8     `Yooo` `YooP8   8   8  `YP`  `Yooo`   `YooP`   8  `YooP` `YooP`  8 `YooP` `YooP.
            :.....::.....::.....::::.....:..:::::.....::.....:::..::..::...:::.....::::.....:::..::.....::.....::..:.....::.....:

            [ victor7w7r ]


            ]], "\n")
          '';
          vertical_center = true;
          center = [
            {
              action = "lua Snacks.dashboard.pick('files')";
              desc = " Buscar...";
              icon = " ";
              key = "f";
            }
            {
              action = "ene | startinsert";
              desc = " Nuevo";
              icon = " ";
              key = "n";
            }
            {
              action = "lua Snacks.dashboard.pick('oldfiles')";
              desc = " Archivos Recientes";
              icon = " ";
              key = "r";
            }
            {
              action = "lua Snacks.dashboard.pick('live_grep')";
              desc = " Buscar Texto";
              icon = " ";
              key = "g";
            }
            {
              action = "lua require('persistence').load()";
              desc = " Restaurar Sesión";
              icon = " ";
              key = "s";
            }
            {
              action.__raw = "function() vim.api.nvim_input('<cmd>qa<cr>') end";
              desc = " Salir";
              icon = " ";
              key = "qa";
            }
          ];

          footer = lib.generators.mkLuaInline ''
            function()
              local stats = require("dashboard.utils").get_package_manager_stats()
              local quote = vim.fn.systemlist({
                "zsh",
                "-fc",
                "autoload -Uz random-quote random-opts lolquotes bofh && random-quote",
              })
              local function wrap_line(line, width)
                if line == "" then
                  return { "" }
                end

                local wrapped = {}
                local current = ""
                for word in line:gmatch("%S+") do
                  if vim.fn.strdisplaywidth(word) > width then
                    if current ~= "" then
                      table.insert(wrapped, current)
                      current = ""
                    end

                    for _, char in ipairs(vim.fn.split(word, "\\zs")) do
                      local candidate = current .. char
                      if current ~= "" and vim.fn.strdisplaywidth(candidate) > width then
                        table.insert(wrapped, current)
                        current = char
                      else
                        current = candidate
                      end
                    end
                  else
                    local candidate = current == "" and word or current .. " " .. word
                    if current ~= "" and vim.fn.strdisplaywidth(candidate) > width then
                      table.insert(wrapped, current)
                      current = word
                    else
                      current = candidate
                    end
                  end
                end

                if current ~= "" then
                  table.insert(wrapped, current)
                end
                return wrapped
              end

              local wrapped_quote = {}
              for _, line in ipairs(quote) do
                vim.list_extend(wrapped_quote, wrap_line(line, 70))
              end

              local footer = {
                "",
                "",
                "✦ Neovim cargado con " .. stats.count .. " plugins ✦",
                "",
              }
              vim.list_extend(footer, wrapped_quote)
              return footer
            end
          '';
        };
      };
    };
  };
}

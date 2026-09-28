{
  den.default.os.programs.nixvim = {
    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { bg = "NONE", fg = "#56398f" })
      vim.api.nvim_set_hl(0, "SnacksDashboardKaomoji", { bg = "NONE", fg = "#45a1ad" })
      vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { bg = "NONE", fg = "#c678dd", italic = true })

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { bg = "NONE", fg = "#56398f" })
          vim.api.nvim_set_hl(0, "SnacksDashboardKaomoji", { bg = "NONE", fg = "#45a1ad" })
          vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { bg = "NONE", fg = "#c678dd", italic = true })
        end,
      })
    '';

    plugins.snacks.settings.dashboard = {
      enabled = true;
      preset.keys = [
        {
          action = "ene | startinsert";
          desc = " Nuevo";
          icon = " ";
          key = "n";

        }
        {
          action.__raw = "function() require('persistence').load({ last = true }) end";
          desc = " Restaurar Sesión";
          icon = " ";
          key = "s";

        }
        {
          action.__raw = "function() Snacks.picker.projects() end";
          desc = " Proyectos Recientes";
          icon = " ";
          key = "o";

        }
        {
          action.__raw = "function() Snacks.dashboard.pick('oldfiles') end";
          desc = " Archivos Recientes";
          icon = " ";
          key = "r";

        }
        {
          action.__raw = "function() Snacks.dashboard.pick('files') end";
          desc = " Buscar Archivo";
          icon = " ";
          key = "f";

        }
        {
          action.__raw = "function() Snacks.dashboard.pick('live_grep') end";
          desc = " Buscar Texto";
          icon = " ";
          key = "g";

        }
        {
          action = ":qa";
          desc = " Salir";
          icon = " ";
          key = "q";
        }
      ];

      sections = [
        {
          text = {
            __unkeyed.__raw = ''
              [[
               .oPYo. .oPYo. .pPYo.   .oPYo.                       o   o                 .oPYo.   o              8  o          *
               8  .o8     `8 8        8    8                       8                     8        8              8             *
                  8 .P`8   .oP` 8oPYo.   8      oPYo. .oPYo. .oPYo.  o8P o8 o    o .oPYo.   `Yooo.  o8P o    o .oPYo8 o8 .oPYo. .oPYo.
                8.d` 8    `b. 8`  `8   8      8  `` 8oooo8 .oooo8   8   8 Y.  .P 8oooo8       `8   8  8    8 8    8  8 8    8 Yb..
                  8o`  8     :8 8.  .P   8    8 8     8.     8    8   8   8 `b..d` 8.            8   8  8    8 8    8  8 8    8   `Yb.
                  `YooP` `YooP` `YooP`   `YooP` 8     `Yooo` `YooP8   8   8  `YP`  `Yooo`   `YooP`   8  `YooP` `YooP`  8 `YooP` `YooP.
              :.....::.....::.....::::.....:..:::::.....::.....:::..::..::...:::.....::::.....:::..::.....::.....::..:.....::.....:

              [ victor7w7r ]

              ]]
            '';
            align = "center";
          };
          hl = "header";
        }
        {
          section = "keys";
          padding = 1;
        }
        {
          icon = " ";
          title = "Archivos Recientes";
          section = "recent_files";
          padding = 1;
        }
        {
          icon = " ";
          title = "Proyectos";
          section = "projects";
          padding = 1;
        }
        {
          indent = 3;
          text = {
            __unkeyed.__raw = ''
              (function()
                 local kaomoji = vim.fn.systemlist({ "zsh", "-fc", "autoload -Uz kaomoji && kaomoji" })[1] or ""
                 return kaomoji
              end)()
            '';
            align = "center";
          };
          hl = "SnacksDashboardKaomoji";
        }
        {
          indent = 3;
          text = {
            __unkeyed.__raw = ''
              (function()
                 local quote = vim.fn.systemlist({ "zsh", "-fc", "autoload -Uz random-quote random-opts lolquotes bofh && random-quote" })[1] or ""
                 return quote
              end)()
            '';
            align = "center";
          };
          hl = "SnacksDashboardFooter";
        }
        {
          text = {
            __unkeyed.__raw = ''
              (function()
                local uv = vim.loop
                local nix_pack_dir = nil
                for path in vim.o.packpath:gmatch('[^,]+') do
                  if path:find('-vim-pack-dir', 1, true) then
                    nix_pack_dir = path .. '/pack/myNeovimPackages'
                    break
                  end
                end

                if not nix_pack_dir then
                  return { count = 0, loaded = 0 }
                end

                local function scan_dir(type)
                  local count, loaded = 0, 0
                  local handle = uv.fs_scandir(nix_pack_dir .. '/' .. type)
                  if not handle then
                    return count, loaded
                  end
                  while true do
                    local name = uv.fs_scandir_next(handle)
                    if not name then
                      break
                    end
                    count = count + 1
                    for _, rtp_path in ipairs(vim.api.nvim_list_runtime_paths()) do
                      if rtp_path:find(name, 1, true) and not rtp_path:match('/after$') then
                        loaded = loaded + 1
                        break
                      end
                    end
                  end
                  return count, loaded
                end

                local start_total, start_loaded = scan_dir('start')
                local opt_total, opt_loaded = scan_dir('opt')

                return "✦ Nixvim cargado con " .. start_loaded + opt_loaded .. "/" .. start_total + opt_total .. " plugins ✦"
              end)()
            '';
            align = "center";
          };
          padding = 2;
          hl = "SnacksDashboardFooter";
        }
      ];
    };
  };
}

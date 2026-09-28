{
  den.default.os = { pkgs, ... }: {
    programs.nixvim = {

      extraPackages = with pkgs; [ chafa ];

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
                ".oPYo. .oPYo. .pPYo.   .oPYo.   o              8  o              *"
                "8  .o8     `8 8        8        8              8                 *"
                "8 .P`8   .oP` 8oPYo.  `Yooo.   o8P o    o .oPYo8 o8 .oPYo. .oPYo. "
                "8.d` 8    `b. 8`  `8       `8   8  8    8 8    8  8 8    8 Yb..   "
                "8o`  8     :8 8.  .P        8   8  8    8 8    8  8 8    8   `Yb. "
                "`YooP` `YooP` `YooP`   `YooP`   8  `YooP` `YooP`  8 `YooP` `YooP. "
                ":.....::.....::.....:::.....:::..::.....::.....::..:.....::.....::"

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
            gap = 1;
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
          {
            pane = 2;
            section = "terminal";
            indent = 20;
            cmd = "chafa /etc/nixos/assets/images/avatar.png --format symbols --symbols vhalf --size 20x20; sleep .1";
            height = 10;
            padding = 1;
            align = "center";
          }
          {
            pane = 2;
            icon = " ";
            title = "Archivos Recientes";
            section = "recent_files";
            padding = 1;
          }
          {
            pane = 2;
            icon = " ";
            title = "Proyectos";
            section = "projects";
            padding = 1;
          }
          {
            pane = 2;
            icon = " ";
            title = "Git Status";
            cmd = "git --no-pager diff --stat -B -M -C";
            height = 10;
            padding = 2;
          }
          {
            pane = 2;
            text = {
              __unkeyed.__raw = ''
                (function()
                  local quote = vim.fn.systemlist({ "zsh", "-fc", "autoload -Uz random-quote random-opts lolquotes bofh && random-quote" })[1] or ""

                  if #quote > 40 then
                    local lines = {}
                    local current = ""

                    for word in quote:gmatch("%S+") do
                      if #current == 0 then
                        current = word
                      elseif #current + 1 + #word <= 40 then
                        current = current .. " " .. word
                      else
                        table.insert(lines, current)
                        current = word
                      end
                    end

                    if #current > 0 then
                      table.insert(lines, current)
                    end

                    return table.concat(lines, "\n")
                  end

                  return quote
                end)()
              '';
              align = "center";
            };
            hl = "SnacksDashboardFooter";
          }
        ];
      };
    };
  };
}

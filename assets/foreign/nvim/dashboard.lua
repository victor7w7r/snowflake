return {
	{
		"nvimdev/dashboard-nvim",
		lazy = false,
		opts = function()
			local logo = [[
  .oPYo. .oPYo. .pPYo.   .oPYo.                       o   o                 .oPYo.   o              8  o        *
	    8  .o8     `8 8        8    8                       8                     8        8              8                *
       8 .P`8   .oP` 8oPYo.   8      oPYo. .oPYo. .oPYo.  o8P o8 o    o .oPYo.   `Yooo.  o8P o    o .oPYo8 o8 .oPYo. .oPYo.
     8.d` 8    `b. 8`  `8   8      8  `` 8oooo8 .oooo8   8   8 Y.  .P 8oooo8       `8   8  8    8 8    8  8 8    8 Yb..
       8o`  8     :8 8.  .P   8    8 8     8.     8    8   8   8 `b..d` 8.            8   8  8    8 8    8  8 8    8   `Yb.
       `YooP` `YooP` `YooP`   `YooP` 8     `Yooo` `YooP8   8   8  `YP`  `Yooo`   `YooP`   8  `YooP` `YooP`  8 `YooP` `YooP.
       :.....::.....::.....::::.....:..:::::.....::.....:::..::..::...:::.....::::.....:::..::.....::.....::..:.....::.....:

       [ victor7w7r ]
      ]]
			logo = string.rep("\n", 1) .. logo .. "\n\n"

			local opts = {
				theme = "doom",
				hide = { statusline = false },
				config = {
					header = vim.split(logo, "\n"),
					-- stylua: ignore
					center = {
						{ action = 'lua LazyVim.pick()()', desc = " Buscar...", icon = " ", key = "f" },
						{ action = "ene | startinsert", desc = " Nuevo", icon = " ", key = "n" },
						{ action = 'lua LazyVim.pick("oldfiles")()', desc = " Archivos recientes", icon = " ", key = "r" },
						{ action = 'lua LazyVim.pick("live_grep")()', desc = " Buscar Texto", icon = " ", key = "g" },
						{ action = 'lua LazyVim.pick.config_files()()', desc = " Config", icon = " ", key = "c" },
						{ action = 'lua require("persistence").load()', desc = " Restaurar Sesión", icon = " ", key = "s" },
						{ action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
						{ action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
						{ action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Salir", icon = " ", key = "q" },
					},
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return { "⚡ Cargado LazyVim con " ..
						stats.loaded .. "/" .. stats.count .. " plugins en " .. ms .. "ms" }
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			if vim.o.filetype == "lazy" then
				vim.api.nvim_create_autocmd("WinClosed", {
					pattern = tostring(vim.api.nvim_get_current_win()),
					once = true,
					callback = function()
						vim.schedule(function()
							vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
						end)
					end,
				})
			end

			return opts
		end,
	}
}

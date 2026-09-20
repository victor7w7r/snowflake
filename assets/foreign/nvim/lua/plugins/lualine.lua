#x_nightfly.normal.c.bg = "none"

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "nightfly",
			globalstatus = true,
			disabled_filetypes = { "dashboard", "lazy", "alpha" },
		},
		sections = {
			lualine_a = { { "mode", icon = "" } },
			--lualine_b = { { "branch", icon = "" }, "diff" },
			--lualine_c = {
			--		{ "filename", path = 1, symbols = { modified = "", readonly = "" } },
			--},
			lualine_x = {
				{ "diagnostics" },
				{ "encoding" },
				{ "filetype",   icon_only = true },
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}

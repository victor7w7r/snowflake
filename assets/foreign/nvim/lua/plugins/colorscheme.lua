return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = { bold = true },
				variables = {},
				sidebars = "transparent",
				floats = "transparent",
			},
			dim_inactive = false,
			lualine_bold = true,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},
}

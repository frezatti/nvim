return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "mocha",
		transparent_background = true,
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
		},
		integrations = {
			cmp = true,
			gitsigns = true,
			treesitter = true,
			telescope = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
		},
	},
	-- We modify the config function to use the opts
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}

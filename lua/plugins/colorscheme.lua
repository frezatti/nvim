return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("catppuccin")
	end,
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
}

return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		vim.cmd("colorscheme rose-pine-moon")
	end,
	opts = {
		enable = {
			terminal = true,
			legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
			migrations = true, -- Handle deprecated options automatically
		},
		background = "none",
	},
}

return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false, -- Load immediately to ensure colorscheme applies
		priority = 1000, -- High priority for colorscheme
		config = function()
			require("dracula").setup({
				-- Customize Dracula settings
				show_end_of_buffer = false, -- Hide '~' characters after buffer
				transparent_bg = true, -- Enable transparent background
				italic_comment = true, -- Enable italic comments
				colors = {
					-- Optional: Customize colors if needed
					-- bg = "#282A36",
					-- fg = "#F8F8F2",
					-- selection = "#44475A",
					-- comment = "#6272A4",
				},
				overrides = {
					-- Optional: Custom highlight groups
					-- Example: Diff colors for vim-fugitive
					DiffAdd = { fg = "#50FA7B", bg = "NONE" }, -- Green for added lines
					DiffDelete = { fg = "#FF5555", bg = "NONE" }, -- Red for deleted lines
					DiffChange = { fg = "#F1FA8C", bg = "NONE" }, -- Yellow for changed lines
				},
				lualine = {
					transparent = true, -- Match transparent background
				},
			})
			-- Set Dracula as the default colorscheme
			vim.cmd.colorscheme("dracula")
		end,
	},
}

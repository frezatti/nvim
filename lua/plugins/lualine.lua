return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- For icons
	event = "VeryLazy",
	opts = {
		options = {
			theme = "auto", -- Matches your colorscheme
			globalstatus = true, -- Single statusline for all windows
		},
		sections = {
			lualine_b = { "branch", "diff" }, -- Git integration
			lualine_c = { "filename", "diagnostics" },
		},
	},
}

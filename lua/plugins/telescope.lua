return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			{
				"<leader>fd",
				function()
					require("telescope").extensions.file_browser.file_browser()
				end,
				desc = "File Browser",
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					file_browser = {
						hijack_netrw = true,
					},
				},
			})
			telescope.load_extension("file_browser")
		end,
	},
}

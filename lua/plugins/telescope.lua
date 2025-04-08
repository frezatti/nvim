return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				-- Your Telescope setup configuration here
			})

			-- Keymap definitions for Telescope built-in pickers
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					file_browser = {
						-- Your Telescope File Browser setup configuration here
						hijack_netrw = true, -- Optionally disable netrw
					},
				},
			})
			telescope.load_extension("file_browser")

			-- Keymap for launching Telescope File Browser
			vim.keymap.set(
				"n",
				"<leader>fd",
				":Telescope file_browser<CR>",
				{ noremap = true, desc = "Telescope File Browser" }
			)
		end,
	},
}

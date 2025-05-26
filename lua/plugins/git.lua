return {
	"tpope/vim-fugitive",
	event = { "BufReadPost", "BufNewFile" }, -- Load on file open
	config = function()
		vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
		vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
		vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
		vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
		vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })
		vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function()
				-- Close fugitive status window with 'q'
				vim.keymap.set("n", "q", ":q<CR>", { buffer = true, desc = "Close fugitive window" })
			end,
		})
	end,
}

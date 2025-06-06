return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		local trouble = require("trouble")

		-- Key mappings
		vim.keymap.set("n", "<leader>xx", function()
			trouble.toggle("diagnostics")
		end, { desc = "Toggle diagnostics (Trouble)" })
		vim.keymap.set("n", "<leader>xX", function()
			trouble.toggle("diagnostics", { filter = { buf = 0 } })
		end, { desc = "Toggle buffer diagnostics (Trouble)" })
		vim.keymap.set("n", "<leader>cs", function()
			trouble.toggle("symbols", { focus = false })
		end, { desc = "Toggle symbols (Trouble)" })
		vim.keymap.set("n", "<leader>cl", function()
			trouble.toggle("lsp", { focus = false, win = { position = "right" } })
		end, { desc = "Toggle LSP definitions/references (Trouble)" })
		vim.keymap.set("n", "<leader>xL", function()
			trouble.toggle("loclist")
		end, { desc = "Toggle location list (Trouble)" })
		vim.keymap.set("n", "<leader>xQ", function()
			trouble.toggle("quickfix")
		end, { desc = "Toggle quickfix list (Trouble)" })
	end,
}

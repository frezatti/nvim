return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Format on save
	cmd = { "ConformInfo" }, -- Command to show formatter info
	dependencies = { "williamboman/mason.nvim" }, -- Depends on Mason to install formatters
	opts = {
		-- Map filetypes to formatters installed via Mason.
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format", "isort", "black" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			sh = { "shfmt" },
			-- c = { "clang-format" },
			-- cpp = { "clang-format" },
		},
		-- Options for formatting on save
		format_on_save = {
			timeout_ms = 500, -- Stop formatting if it takes too long
			lsp_fallback = true, -- Use LSP formatting if conform formatter fails
		},
	},
	-- Optional: Add a keymap for manual formatting
	init = function()
		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format buffer" })
	end,
}

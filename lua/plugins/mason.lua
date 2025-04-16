return {
	{
		"williamboman/mason.nvim",
		lazy = false, -- Ensure Mason is loaded eagerly to install tools
		config = true, -- Default setup call
	},
	{
		"williamboman/mason-lspconfig.nvim",
		-- No config needed here, lsp.lua handles the setup call
		dependencies = { "williamboman/mason.nvim" },
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			-- A list of tools to ensure are installed. Mason will install them automatically.
			-- Add LSP servers, DAP servers, linters, and formatters here.
			ensure_installed = {
				-- LSP Servers
				"lua_ls",
				"cssls",
				"html",
				"pyright",
				"typescript-language-server",
				"bashls",
				"jsonls",
				"yamlls",
				"marksman",
				-- Add other LSPs...

				-- Formatters
				"stylua",
				"prettier", -- Installs prettierd by default, which is faster
				"black",
				"isort",
				"shfmt",
				--"ruff_format",
				-- Add other formatters...

				-- Linters (Example)
				-- 'eslint_d',
				-- 'ruff',
				-- Add other linters...

				-- DAP Servers (Example)
				-- 'python-debugpy',
				-- Add other DAPs...
			},
			-- You can add options like auto_update = true, run_on_start = true
		},
	},
}

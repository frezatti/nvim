return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" }, -- Load LSP config on buffer events
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Optional dep if mason.lua handles it

		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		{ "folke/neodev.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
		"nvimdev/lspsaga.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "LSP: Show line diagnostics" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Go to previous diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Go to next diagnostic" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "LSP: Open diagnostics list" })

		local on_attach = function(client, bufnr)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
			end

			local lspsaga_avail, lspsaga = pcall(require, "lspsaga.lsp")
			local telescope_avail, telescope = pcall(require, "telescope.builtin")

			map("K", function()
				if lspsaga_avail then
					lspsaga.hover_doc()
				else
					vim.lsp.buf.hover()
				end
			end, "Hover Documentation")

			if telescope_avail then
				map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
				map("gr", telescope.lsp_references, "[G]oto [R]eferences")
				map("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", telescope.lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			else
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
				map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
				-- No easy fallback for symbols without Telescope or similar
			end

			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

			map("<leader>rn", function()
				if lspsaga_avail then
					lspsaga.rename()
				else
					vim.lsp.buf.rename()
				end
			end, "[R]e[n]ame")

			map("<leader>ca", function()
				if lspsaga_avail then
					lspsaga.code_action()
				else
					vim.lsp.buf.code_action()
				end
			end, "[C]ode [A]ction")

			if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
				local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = bufnr,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})
				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			-- Inlay Hints (same as your original config)
			if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
				end, "[T]oggle Inlay [H]ints")
			end
		end -- end on_attach

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = { checkThirdParty = false }, -- Adjust as needed
								telemetry = { enable = false },
							},
						},
					})
				end,
			},
		})
	end,
}

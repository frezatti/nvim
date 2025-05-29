return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" }, -- Load LSP config on buffer events
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		-- Crucial for Lua LSP autocompletion and diagnostics (e.g., 'vim' global)
		{
			"folke/neodev.nvim",
			opts = {
				library = {
					enabled = true,
					runtime = true, -- Recognizes Neovim's core Lua runtime
					types = true, -- Provides types for vim.api, vim.lsp, etc.
					plugins = true, -- Provides types for your installed plugins
				},
			},
		},
		"hrsh7th/cmp-nvim-lsp",
		"nvimdev/lspsaga.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Explicitly set positionEncoding for better LSP communication
		capabilities.textDocument.positionEncoding = "utf-16"

		-- Set up nvim-cmp for autocompletion with Tab navigation
		local cmp = require("cmp")
		cmp.setup({
			mapping = {
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP completion source
			}),
		})

		-- Global diagnostic keymaps
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "LSP: Show line diagnostics" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Go to previous diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Go to next diagnostic" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "LSP: Open diagnostics list" })

		local on_attach = function(client, bufnr)
			-- Helper function for setting buffer-local keymaps
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
			end

			local lspsaga_avail, lspsaga = pcall(require, "lspsaga.lsp")
			local telescope_avail, telescope = pcall(require, "telescope.builtin")

			-- LSP Hover Documentation
			map("K", function()
				if lspsaga_avail then
					lspsaga.hover_doc()
				else
					vim.lsp.buf.hover()
				end
			end, "Hover Documentation")

			-- Standard LSP Go To (auto-jumps if one result, quickfix/list if many)
			map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition") -- Go to definition
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration") -- Go to declaration

			-- Telescope-specific LSP keymaps for interactive pickers
			if telescope_avail then
				-- Use <leader>l prefix for Telescope's LSP pickers
				map("<leader>ld", function()
					telescope.lsp_definitions({ bufnr = bufnr, client = client })
				end, "Telescope [L]SP [D]efinitions")
				map("<leader>lD", function()
					telescope.lsp_declaration({ bufnr = bufnr, client = client })
				end, "Telescope [L]SP [D]eclaration")
				map("gr", function()
					telescope.lsp_references({ bufnr = bufnr, client = client })
				end, "[G]oto [R]eferences")
				map("gI", function()
					telescope.lsp_implementations({ bufnr = bufnr, client = client })
				end, "[G]oto [I]mplementation")
				map("<leader>D", function()
					telescope.lsp_type_definitions({ bufnr = bufnr, client = client })
				end, "Type [D]efinition")
				map("<leader>ds", function()
					telescope.lsp_document_symbols({ bufnr = bufnr, client = client })
				end, "[D]ocument [S]ymbols")
				map("<leader>ws", function()
					telescope.lsp_dynamic_workspace_symbols({ bufnr = bufnr, client = client })
				end, "[W]orkspace [S]ymbols")
			else
				vim.notify("Telescope not available for advanced LSP pickers.", vim.log.levels.WARN)
			end

			-- Rename and Code Action
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

				-- Specific handler for lua_ls
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = {
									globals = { "vim" }, -- Crucial for recognizing the 'vim' global
								},
								workspace = {
									checkThirdParty = false,
									-- neodev.nvim automatically manages the 'library' field here
									-- to include Neovim runtime and plugin definitions.
								},
								telemetry = { enable = false },
							},
						},
					})
				end,
			},
		})
	end, -- end config function
}

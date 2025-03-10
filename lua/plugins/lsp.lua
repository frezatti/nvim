return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"AstroNvim/astrolsp",
			opts = {
				features = {
					codelens = true,
					inlay_hints = true,
					semantic_tokens = true,
				},
				autocmds = {
					lsp_document_highlight = {
						cond = "textDocument/documentHighlight",
						{
							event = { "CursorHold", "CursorHoldI" },
							desc = "Document Highlighting",
							callback = function()
								vim.lsp.buf.document_highlight()
							end,
						},
						{
							event = { "CursorMoved", "CursorMovedI", "BufLeave" },
							desc = "Document Highlighting Clear",
							callback = function()
								vim.lsp.buf.clear_references()
							end,
						},
					},
				},
				commands = {
					Format = {
						function()
							vim.lsp.buf.format()
						end,
						cond = "textDocument/formatting",
						desc = "Format file with LSP",
					},
				},
				capabilities = {
					textDocument = {
						foldingRange = { dynamicRegistration = false },
					},
				},
				config = {
					lua_ls = {
						settings = {
							Lua = {
								hint = { enable = true, arrayIndex = "Disable" },
							},
						},
					},
					clangd = {
						capabilities = {
							offsetEncoding = "utf-8",
						},
					},
				},
				file_operations = {
					timeout = 10000,
					operations = {
						willRename = true,
						didRename = true,
						willCreate = true,
						didCreate = true,
						willDelete = true,
						didDelete = true,
					},
				},
				flags = {
					exit_timeout = 5000,
				},
				formatting = {
					format_on_save = {
						enabled = false, -- **DISABLE astrolsp's format_on_save**
					},
					disabled = {},
					timeout_ms = 1000,
					filter = function(client)
						return true
					end,
				},
				handlers = {
					function(server, opts)
						require("lspconfig")[server].setup(opts)
					end,
					pyright = function(_, opts)
						require("lspconfig").pyright.setup(opts)
					end,
					rust_analyzer = false,
				},
				lsp_handlers = {
					["textDocument/hover"] = vim.lsp.with(
						vim.lsp.handlers.hover,
						{ border = "rounded", silent = true }
					),
					["textDocument/signatureHelp"] = false,
				},
				mappings = {
					n = {
						gl = {
							function()
								vim.diagnostic.open_float()
							end,
							desc = "Hover diagnostics",
						},
						["<leader>uY"] = {
							function()
								require("astrolsp.toggles").buffer_semantic_tokens()
							end,
							desc = "Toggle LSP semantic highlight (buffer)",
							cond = function(client, bufnr)
								return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens
							end,
						},
						gd = {
							function()
								require("telescope.builtin").lsp_definitions()
							end,
							desc = "[G]oto [D]efinition",
						},
						gr = {
							function()
								require("telescope.builtin").lsp_references()
							end,
							desc = "[G]oto [R]eferences",
						},
						gI = {
							function()
								require("telescope.builtin").lsp_implementations()
							end,
							desc = "[G]oto [I]mplementation",
						},
						["<leader>D"] = {
							function()
								require("telescope.builtin").lsp_type_definitions()
							end,
							desc = "Type [D]efinition",
						},
						["<leader>ds"] = {
							function()
								require("telescope.builtin").lsp_document_symbols()
							end,
							desc = "[D]ocument [S]ymbols",
						},
						["<leader>ws"] = {
							function()
								require("telescope.builtin").lsp_dynamic_workspace_symbols()
							end,
							desc = "[W]orkspace [S]ymbols",
						},
						["<leader>rn"] = {
							function()
								vim.lsp.buf.rename()
							end,
							desc = "[R]e[n]ame",
						},
						["<leader>ca"] = {
							function()
								vim.lsp.buf.code_action()
							end,
							desc = "[C]ode [A]ction",
						},
						["gD"] = {
							function()
								vim.lsp.buf.declaration()
							end,
							desc = "[G]oto [D]eclaration",
						},
					},
				},
				servers = { "dartls" },
				-- on_attach = function(client, bufnr) client.server_capabilities.semanticTokensProvider = nil end, -- Removed earlier
			},
		},
		{
			"williamboman/mason-lspconfig.nvim",
			dependencies = { "williamboman/mason.nvim" },
			lazy = false,
			config = function()
				require("mason-lspconfig").setup({
					automatic_installation = true,
					ensure_installed = {
						"vimls",
						"lua_ls",
						"gopls",
						"marksman",
						"jsonls",
						"clangd",
						"cssls",
						"yamlls",
						"html",
						"tailwindcss",
						"ruby_lsp",
						"rust_analyzer",
					},
					handlers = {
						function(server)
							require("astrolsp").lsp_setup(server)
						end,
					},
				})
			end,
		},
		{
			"williamboman/mason.nvim",
			lazy = false,
			config = function()
				require("mason").setup()
			end,
		},
		-- **conform.nvim plugin block:**
		{
			"stevearc/conform.nvim",
			lazy = false,
			config = function()
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" }, -- For Lua files, use "stylua" formatter (install stylua separately if needed)
						go = { "gofmt", "goimports" }, -- For Go files, use "gofmt" and "goimports"
					},
					fallback_formatters = { "prettier" },
					format_on_save = {
						lsp_fallback = true,
						timeout_ms = 500,
					},
				})
			end,
		},
	},
	config = function()
		vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
	end,
}

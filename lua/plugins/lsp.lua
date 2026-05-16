return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", config = true },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		-- 1. Setup Diagnostic Icons & UI
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ", -- Error icon
					[vim.diagnostic.severity.WARN] = " ", -- Warning icon
					[vim.diagnostic.severity.INFO] = " ", -- Info icon
					[vim.diagnostic.severity.HINT] = "󰌵 ", -- Lightbulb for hints
				},
			},
			virtual_text = {
				prefix = "●", -- Changes the inline text prefix to a dot
			},
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				border = "rounded", -- Adds a nice rounded border to the floating window
				source = "always", -- Tells you which tool sent the warning (e.g., Roslyn or Csharpier)
			},
		})

		-- ... the rest of your existing LspAttach code ...
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Snacks Picker Mappings
				map("gd", function()
					Snacks.picker.lsp_definitions()
				end, "[G]oto [D]efinition")
				map("gr", function()
					Snacks.picker.lsp_references()
				end, "[G]oto [R]eferences")
				map("gI", function()
					Snacks.picker.lsp_implementations()
				end, "[G]oto [I]mplementation")
				map("<leader>D", function()
					Snacks.picker.lsp_type_definitions()
				end, "Type [D]efinition")
				map("<leader>ds", function()
					Snacks.picker.lsp_symbols()
				end, "[D]ocument [S]ymbols")
				map("<leader>ws", function()
					Snacks.picker.lsp_workspace_symbols()
				end, "[W]orkspace [S]ymbols")

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
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

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local servers = {
			lua_ls = { settings = { Lua = { completion = { callSnippet = "Replace" } } } },
			pyright = {},
			ts_ls = {},
			cssls = {},
			gopls = {},
		}

		require("mason").setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		})

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"prettierd",
			"delve",
			"goimports",
			"gofumpt",
			"golines",
			"isort",
			"black",
			"clang-format",
			"netcoredbg",
		})

		for i, v in ipairs(ensure_installed) do
			if v == "ts_ls" then
				ensure_installed[i] = "typescript-language-server"
			elseif v == "lua_ls" then
				ensure_installed[i] = "lua-language-server"
			elseif v == "cssls" then
				ensure_installed[i] = "css-lsp"
			end
		end

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			integrations = { ["mason-lspconfig"] = false },
			run_on_start = true,
			start_delay = 3000,
		})

		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}

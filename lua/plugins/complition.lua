return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter", -- Load on entering insert mode
	dependencies = {
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		"hrsh7th/cmp-cmdline", -- cmdline completions
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- snippet source for nvim-cmp
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- Make luasnip aware of vscode-style snippets (optional)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- Previous item
				["<C-j>"] = cmp.mapping.select_next_item(), -- Next item
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- Show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- Close completion window
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection (accept completion)
			}),
			-- Sources for completion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				-- Add other sources here
			}),
			-- Configure appearance (optional)
			-- window = {
			--   completion = cmp.config.window.bordered(),
			--   documentation = cmp.config.window.bordered(),
			-- },
		})
	end,
}

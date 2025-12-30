return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- add blink-compat if you need to use other cmp plugins
	},
	version = "*", -- Use the latest release

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for navigation)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full documentation for more details
		keymap = {
			preset = "default",

			-- Reuse your previous keymap preferences:
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see :help blink.cmp)
					score_offset = 100,
				},
			},
		},

		-- Blink has native snippet support, so we don't need 'LuaSnip' plugin anymore.
		-- It still uses 'friendly-snippets' automatically.
		snippets = { preset = "default" },

		-- Experimental signature help (like type hints as you type arguments)
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}

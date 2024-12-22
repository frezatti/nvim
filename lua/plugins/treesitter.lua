return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	ops = {
		-- A list of parser names, or "all" (the five listed parsers should always be installed)
		ensure_installed = { "javascript", "go", "typescript", "rust", "cpp", "c", "lua", "vim", "vimdoc", "query" },

		sync_install = false,

		auto_install = true,

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "ruby" },
		},
	},
}

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = { "javascript", "go", "typescript", "rust", "cpp", "c", "lua", "vim", "vimdoc", "query" },
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true, -- Enable Treesitter-based indentation
		},
	},
}

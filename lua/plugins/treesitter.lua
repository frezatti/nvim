return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"javascript",
			"go",
			"typescript",
			"rust",
			"cpp",
			"c",
			"lua",
			"vim",
			"ruby",
			"vimdoc",
			"query",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
}

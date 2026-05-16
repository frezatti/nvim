return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
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
			"vimdoc",
			"query",
			"ruby",
			"prisma",
			"zig",
			"c_sharp",

			-- Markdown
			"markdown",
			"markdown_inline",

			-- Common config/web files
			"html",
			"css",
			"json",
			"yaml",
			"toml",
			"bash",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
}

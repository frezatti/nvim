local parsers = {
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
	"regex",
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
}
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").setup()

		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"javascript",
				"typescript",
				"go",
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
				"cs",
				"markdown",
				"html",
				"css",
				"json",
				"yaml",
				"toml",
				"bash",
				"sh",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}

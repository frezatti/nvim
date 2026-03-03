return {
	"echasnovski/mini.surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("mini.surround").setup({
			-- sa = "Add surround", sd = "Delete surround", sr = "Replace surround"
		})
	end,
}

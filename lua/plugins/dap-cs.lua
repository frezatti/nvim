return {
	"NicholasMata/nvim-dap-cs",
	dependencies = { "mfussenegger/nvim-dap" },
	ft = "cs",
	config = function()
		require("dap-cs").setup({
			netcoredbg_path = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
		})
	end,
}

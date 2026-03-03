return {
	"NicholasMata/nvim-dap-cs",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		require("dap-cs").setup({
			netcoredbg_path = "netcoredbg",
		})
	end,
}

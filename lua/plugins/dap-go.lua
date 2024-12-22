return {
	"leoluz/nvim-dap-go",
	config = function()
		require("dap-go").setup({
			dap_configurations = {
				{
					-- Must be "go" or it will be ignored by the plugin
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
			},
			delve = {
				path = "dlv",
				initialize_timeout_sec = 20,
				port = "${port}",
				-- additional args to pass to dlv
				args = {},
				build_flags = {},
				detached = vim.fn.has("win32") == 0,
				cwd = nil,
			},
			-- options related to running closest test
			tests = {
				-- enables verbosity when running the test.
				verbose = false,
			},
		})
	end,
}

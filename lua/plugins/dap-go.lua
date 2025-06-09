return {
	 "leoluz/nvim-dap-go",
  dependencies = { "mfussenegger/nvim-dap" },
  -- Lazy-load only for Go files
  ft = "go",
  keys = {
    { "<space>td", function() require("dap-go").debug_test() end, desc = "DAP: Debug Go Test" }
  },
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

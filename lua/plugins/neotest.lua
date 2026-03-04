return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- The C# specific adapter
		"Issafalcon/neotest-dotnet",
	},
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").run.run()
			end,
			desc = "Run Nearest Test",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug Nearest Test",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run Current Test File",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle Test Summary Window",
		},
		{
			"<leader>to",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle Test Output Panel",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-dotnet")({
					-- Uses the standard dotnet cli for testing
					dap = {
						-- Must match the adapter name you setup in your dap config
						adapter_name = "coreclr",
					},
					-- Let the plugin automatically discover test projects
					discovery_root = "project",
				}),
			},
			-- Use the nice icons you already have installed
			icons = {
				passed = "✔",
				running = "↻",
				failed = "✖",
				unknown = "?",
			},
		})
	end,
}

return {
	"mfussenegger/nvim-dap",
	keys = {
		-- Your existing keys
		{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "DAP: Toggle Breakpoint" },
		{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "DAP: Continue" },

		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "DAP: Step Over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "DAP: Step Into",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "DAP: Step Out",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "DAP: Terminate Session",
		},

		-- A quick way to evaluate the variable under your cursor
		{
			"<leader>de",
			function()
				require("dapui").eval()
			end,
			desc = "DAP: Evaluate Variable",
		},
	},
}

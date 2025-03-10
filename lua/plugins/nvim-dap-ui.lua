return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		local dapui = require("dapui")
		dapui.setup({
			icons = { -- Customize icons
				expanded = "▾",
				collapsed = "▸",
				open = "",
				closed = "",
			},
			controls = { -- Customize control icons/labels
				icons = {
					pause = "",
					play = "",
					step_over = "󰜴",
					step_into = "󰜵",
					step_out = "󰜶",
					up = "",
					down = "",
					run_last = "",
					terminate = "",
					disconnect = "",
				},
			},
			layouts = { -- Customize layouts (windows arrangement)
				{
					elements = {
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{ id = "repl", size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					position = "bottom",
					size = 10,
				},
			},
			float = {
				max_height = nil,
				max_width = nil, -- Floats will be treated as percentage of your screen.
				border = "single", -- Border style. Can be 'single', 'double', 'rounded', 'solid', 'shadow', or 'none', or a table of 8 characters to define the border.
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = {
				breakpoints = {
					open_commands = { "DapUiBreakpoints", "DapUiToggleBreakpoints" },
				},
				watches = {
					open_commands = { "DapUiWatches", "DapUiToggleWatches" },
				},
				stacks = {
					open_commands = { "DapUiStacks", "DapUiToggleStacks" },
				},
				scopes = {
					open_commands = { "DapUiScopes", "DapUiToggleScopes" },
				},
				console = {
					open_commands = { "DapUiConsole", "DapUiToggleConsole" },
				},
				repl = {
					open_commands = { "DapUiRepl", "DapUiToggleRepl" },
				},
			},
			render = {
				max_type_length = nil, -- Can be integer or nil. Setting it to a positive number will truncate values in the "Scopes" window.
				indent_lines = true,
				max_value_lines = 10, -- Maximum lines for multiline values in "Scopes" window. Set to nil to disable.
				multiline_fold_threshold = 20, -- Lines greater than this value will be folded in "Scopes" window.
			},
		})
	end,
}

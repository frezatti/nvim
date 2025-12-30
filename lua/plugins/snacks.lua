return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- BIG FEATURES
		dashboard = { enabled = false }, -- Explicitly disabled as requested
		explorer = { enabled = true }, -- A fast file explorer (optional, since you use Oil)
		picker = { enabled = true }, -- Replaces functionality of Telescope/Dressing for selections

		-- QUALITY OF LIFE (The stuff you were missing)
		indent = { enabled = true }, -- Adds vertical indentation lines
		input = { enabled = true }, -- Better UI for "Renaming" (Replaces Dressing)
		notifier = { enabled = true }, -- Better notification cards
		scope = { enabled = true }, -- Highlights the specific code block you are in
		scroll = { enabled = true }, -- Smooth scrolling
		statuscolumn = { enabled = true }, -- Git signs in the number column
		words = { enabled = true }, -- Highlights words referencing the one under cursor
	},
	keys = {
		-- PICKER (File Search)
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep (Find Text)",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find Buffers",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Tags",
		},

		-- PICKER (Git)
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},

		-- OTHER USEFUL UTILITIES
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "LazyGit",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
	},
}

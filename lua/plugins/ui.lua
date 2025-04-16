return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach", -- Load when LSP attaches
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- Required for some features
			"nvim-web-devicons/nvim-web-devicons", -- Optional for icons
		},
		opts = {
			-- Configuration options for lspsaga (see their docs)
			ui = {
				border = "rounded",
				code_action = "💡",
				-- Example: Use icons for diagnostics
				diagnostic = {
					show_code_action = true,
					show_source = true,
					jump_num_shortcut = true,
					keys = {
						exec_action = "o",
						quit = "q",
						go_action = "g",
					},
				},
			},
			finder = {
				-- keys = { -- Remap finder actions if needed }
			},
			lightbulb = {
				enable = false, -- Disable if using code_action keymap primarily
			},
			-- Add other customizations
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope", -- Load when running the Telescope command
		version = false, -- telescope did only one release, so using HEAD is fine now
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Optional: Preview enhancements
			-- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			-- { 'nvim-telescope/telescope-ui-select.nvim' },
		},
		opts = {
			defaults = {
				-- Default layout strategy
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				sorting_strategy = "ascending",
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				use_less = true,
				path_display = { "truncate" },
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			},
			-- extensions = {
			--   ['ui-select'] = {
			--     require('telescope.themes').get_dropdown(),
			--   },
			-- },
		},
		-- config = function(_, opts)
		--   -- require('telescope').setup(opts)
		--   -- Optional: Load extensions
		--   -- require('telescope').load_extension('fzf')
		--   -- require('telescope').load_extension('ui-select')
		-- end,
	},

	-- Optional: Icons
	{ "nvim-web-devicons/nvim-web-devicons", lazy = true, opts = { default = true } },
}

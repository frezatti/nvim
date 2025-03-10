local rose_pine_colors = {

	base = "#191724",

	surface = "#1f1d2e",

	overlay = "#26233a",

	muted = "#6e6a86",

	subtle = "#908caa",

	text = "#e0def4",

	love = "#eb6f92",

	gold = "#f6c177",

	rose = "#ebbcba",

	pine = "#31748f",

	foam = "#9ccfd8",

	iris = "#c4a7e7",

	highlight_low = "#21202e",

	highlight_med = "#403d52",

	highlight_high = "#524f67",
}

local options = {

	base46 = {
		theme = "onedark", -- Revert to a default theme for testing UI elements
	},

	statusline = {
		enabled = true,
		colors = {

			fg = rose_pine_colors.text,

			bg = rose_pine_colors.base,

			inactive_fg = rose_pine_colors.subtle,

			inactive_bg = rose_pine_colors.surface,

			normal_mode_color = rose_pine_colors.pine,

			insert_mode_color = rose_pine_colors.foam,

			visual_mode_color = rose_pine_colors.gold,

			replace_mode_color = rose_pine_colors.love,

			command_mode_color = rose_pine_colors.iris,

			terminal_mode_color = rose_pine_colors.rose,

			-- Add more statusline color customizations as needed,

			-- Refer to NvChad UI documentation for available statusline color groups
		},
	},

	tabufline = {

		colors = {

			active_fg = rose_pine_colors.text,

			active_bg = rose_pine_colors.surface,

			inactive_fg = rose_pine_colors.subtle,

			inactive_bg = rose_pine_colors.base,

			--buffer_indicator_fg = rose_pine_colors.pine, -- Example, adjust as needed

			--close_button_bg = rose_pine_colors.love,     -- Example, adjust as needed

			-- ... Customize other tabufline colors ...

			-- Refer to NvChad UI documentation for tabufline color options
		},
	},

	nvdash = {

		components = {

			header = {

				style = {

					fg = rose_pine_colors.text,

					bg = rose_pine_colors.overlay, -- Example background for header
				},
			},

			body = {

				style = {

					fg = rose_pine_colors.subtle,

					bg = rose_pine_colors.base, -- Example background for body
				},
			},

			footer = {

				style = {

					fg = rose_pine_colors.muted,

					bg = rose_pine_colors.surface, -- Example background for footer
				},
			},
		},
	},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})

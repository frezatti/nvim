return {
	{
		"omarchy-colorscheme-sync",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		priority = 1000,

		dependencies = {
			"catppuccin/nvim", -- Catppuccin variants
			"ellisonleao/gruvbox.nvim", -- Gruvbox
			"rebelot/kanagawa.nvim", -- Kanagawa (Osaka Sakura)
			"folke/tokyonight.nvim", -- Tokyo Night
			"rose-pine/neovim", -- Rose Pine
			"sainnhe/everforest", -- Everforest (Osaka Jade/Green)
			"tahayvr/matteblack.nvim", -- Matte Black
			"ribru17/bamboo.nvim", -- Bamboo (this is what you're missing)
			"bluz71/vim-nightfly-colors", -- Nightfly
			"bluz71/vim-moonfly-colors", -- Moonfly
			"EdenEast/nightfox.nvim", -- Nightfox
			"savq/melange-nvim", -- Melange
			"projekt0n/github-nvim-theme", -- GitHub theme
			"Mofiqul/dracula.nvim", -- Dracula
			"navarasu/onedark.nvim", -- One Dark
			"olimorris/onedarkpro.nvim", -- One Dark Pro
			"shaunsingh/nord.nvim", -- Nord
			"srcery-colors/srcery-vim", -- Srcery
			"theniceboy/nvim-deus", -- Deus
			"sainnhe/sonokai", -- Sonokai
			"sainnhe/edge", -- Edge
			"sainnhe/gruvbox-material", -- Gruvbox Material
			"yonlu/omni.vim", -- Omni
			"rmehri01/onenord.nvim", -- Onenord
			"phha/zenburn.nvim", -- Zenburn
			"ray-x/lsp_signature.nvim", -- LSP Signature (some themes include this)
		},

		config = function()
			-- Function to extract colorscheme name from Omarchy theme
			local function get_omarchy_colorscheme()
				local theme_path = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
				if vim.fn.filereadable(theme_path) ~= 1 then
					return nil
				end

				local ok, theme_spec = pcall(dofile, theme_path)
				if not ok or not theme_spec then
					return nil
				end

				for _, spec in ipairs(theme_spec) do
					if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
						return spec.opts.colorscheme
					elseif spec.opts and spec.opts.colorscheme then
						return spec.opts.colorscheme
					end
				end
				return nil
			end

			-- Apply theme on startup
			local colorscheme = get_omarchy_colorscheme()
			if colorscheme then
				vim.cmd.colorscheme(colorscheme)
			end

			-- Auto-apply when Omarchy theme changes
			vim.api.nvim_create_autocmd("User", {
				pattern = "OmarchyThemeChanged",
				callback = function()
					vim.schedule(function()
						local new_colorscheme = get_omarchy_colorscheme()
						if new_colorscheme then
							vim.cmd.colorscheme(new_colorscheme)
							vim.cmd("redraw!")
						end
					end)
				end,
			})
		end,
	},
}

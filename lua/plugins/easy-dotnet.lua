return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>cb", "<cmd>Dotnet build<cr>", desc = ".NET Build" },
		{ "<leader>cr", "<cmd>Dotnet run<cr>", desc = ".NET Run" },
		{ "<leader>cc", "<cmd>Dotnet clean<cr>", desc = ".NET Clean" },
		{ "<leader>ct", "<cmd>Dotnet test<cr>", desc = ".NET Test" },
		{ "<leader>cT", "<cmd>Dotnet testrunner<cr>", desc = ".NET TestRunner" },
		{ "<leader>cp", "<cmd>Dotnet project view<cr>", desc = ".NET Project Manager" },
	},
	config = function()
		require("easy-dotnet").setup({
			auto_bootstrap_namespace = true,
		})
	end,
}

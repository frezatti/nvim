return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>cb", "<cmd>Dotnet build<cr>", desc = ".NET Build" },
		{ "<leader>cr", "<cmd>Dotnet run<cr>", desc = ".NET Run" },
		{ "<leader>ct", "<cmd>Dotnet test<cr>", desc = ".NET Test" },
		{ "<leader>cp", "<cmd>Dotnet project<cr>", desc = ".NET Project Manager" },
	},
	config = function()
		require("easy-dotnet").setup({
			test_runner = {
				view_command = "neotest",
			},
			-- Automatically find the .sln or .csproj file in your root directory
			auto_bootstrap_namespace = true,
		})
	end,
}

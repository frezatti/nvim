return {
	"seblyng/roslyn.nvim",
	ft = "cs",
	opts = {},
	settings = {
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
			csharp_enable_inlay_hints_for_parameter_names = true,
		},
		["csharp|code_lens"] = {
			dotnet_enable_references_code_lens = true,
			dotnet_enable_tests_code_lens = true,
		},
	},
}

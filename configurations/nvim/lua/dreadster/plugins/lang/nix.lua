return {
	{
		"conform",
		optional = true,
		opts = {
			formatters_by_ft = {
				nix = { "nixfmt" },
			},
		},
	},
	{
		"nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				nix = { "statix", "deadnix" },
			},
		},
	},
}

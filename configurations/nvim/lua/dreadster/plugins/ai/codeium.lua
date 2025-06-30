return {
	{
		"Exafunction/windsurf.nvim",
		name = "codeium",
		main = "codeium",
		event = "InsertEnter",
		cmd = { "Codeium" },
		build = ":Codeium Auth",
		enabled = false,
		opts = {
			enable_cmp_source = true,
			virtual_text = {
				enabled = false,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		dependencies = { "codeium" },
		opts = function(_, opts)
			table.insert(opts.sources, 1, {
				name = "codeium",
				group_index = 1,
				priority = 100,
			})
		end,
	},
}

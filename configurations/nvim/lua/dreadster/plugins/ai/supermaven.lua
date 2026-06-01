return {
	{
		"supermaven-inc/supermaven-nvim",
		commit = "07d20fce48a5629686aefb0a7cd4b25e33947d50",
		name = "supermaven",
		event = "InsertEnter",
		enabled = function()
			return not require("dreadster.utils").is_mac()
		end,
		opts = {
			disable_inline_completion = true,
		},
	},
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		dependencies = { "supermaven" },
		opts = function(_, opts)
			table.insert(opts.sources, 1, {
				name = "supermaven",
				priority = 1100,
				group_index = 1,
			})
		end,
	},
}

return {
	{
		"supermaven-inc/supermaven-nvim",
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
				group_index = 1,
				priority = 100,
			})
		end,
	},
}

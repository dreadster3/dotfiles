return {
	{
		"Exafunction/codeium.nvim",
		main = "codeium",
		enabled = function()
			return not require("dreadster.utils").is_mac()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {},
	},
}

return {
	{
		"Exafunction/codeium.nvim",
		main = "codeium",
		event = "InsertEnter",
		cmd = { "Codeium" },
		build = ":Codeium Auth",
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

return {
	{
		"grafana/vim-alloy",
		commit = "0273f88f7199189f9a0f32213a34ab778e226f86",
		ft = "alloy",
		config = function()
			vim.g.alloy_fmt_on_save = 0
		end,
	},
}

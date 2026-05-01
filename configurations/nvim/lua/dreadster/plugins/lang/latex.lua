return {
	{
		"lervag/vimtex",
		name = "vimtex",
		lazy = false,
		init = function()
			-- Vimtex settings
			vim.g.vimtex_quickfix_open_on_warning = 0
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "build",
				aux_dir = "build",
				out_dir = "build",
			}
		end,
	},
}

vim.opt.autoindent = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.tabstop = 4

vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.wrap = false

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.completeopt = {"menuone", "noselect", "noinsert" }

vim.g.copilot_assume_mapped = true

vim.g.vimtex_quickfix_open_on_warning = 0

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = {"*.tf"},
	callback  = function ()
		vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
		vim.api.nvim_buf_set_option(0, "filetype", "terraform")
	end
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = {"*.tex"},
	callback  = function ()
		vim.opt_local.spell = true
	end
})

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
	build_dir = "build",
	aux_dir = "build",
	out_dir = "build"
}

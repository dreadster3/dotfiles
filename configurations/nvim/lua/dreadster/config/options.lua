-- General settings
-- Indentation Settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 8
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Line Number settings
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "yes"

-- Search settings
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.wrap = false
vim.opt.title = true
vim.opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "

-- Fold settings
vim.opt.foldenable = true
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.background = "dark"

-- Copy + Paste WSL
local utils = require("dreadster.utils")
if utils.is_wsl() then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = { ["+"] = "clip.exe", ["*"] = "clip.exe" },
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

-- Vimtex settings
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
	build_dir = "build",
	aux_dir = "build",
	out_dir = "build",
}

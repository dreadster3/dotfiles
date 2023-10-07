-- General settings
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 8

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"

vim.opt.title = true
vim.opt.termguicolors = true

vim.g.mapleader = " "

-- Fold settings
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.background = "dark"

-- Copy + Paste WSL
local utils = require("dreadster.utils")
if utils.is_wsl() then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {["+"] = "clip.exe", ["*"] = "clip.exe"},
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
        },
        cache_enabled = 0
    }
end

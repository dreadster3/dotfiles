-- General settings
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.tabstop = 4

vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.wrap = false

vim.opt.title = true
vim.opt.termguicolors = true

vim.g.mapleader = " "

-- NvimTree Settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fold settings
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Copilot settings
-- Set proxy when using copilot on mac
local utils = require("dreadster.utils")
if utils.is_mac() then vim.g.copilot_proxy = os.getenv("http_proxy") end

vim.g.copilot_assume_mapped = true

-- Vimtex settings
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
    build_dir = "build",
    aux_dir = "build",
    out_dir = "build"
}

-- Vimade
vim.g.vimade = {detecttermcolors = 1}

-- Copy + Paste WSL
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

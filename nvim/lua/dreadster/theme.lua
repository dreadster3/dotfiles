local utils = require("dreadster.utils")
if not utils.check_module_installed("catppuccin") then return end

require('catppuccin').setup({
    transparent_background = true,
    integrations = {
        treesitter = true,
        cmp = true,
        gitsigns = true,
        lsp_saga = true,
        mason = true,
        notify = true,
        telescope = true,
        dap = true,
        alpha = true,
        markdown = true,
        which_key = true,
        nvimtree = true,
        illuminate = true,
        lsp_trouble = true,
        ts_rainbow2 = true
    }
})

vim.opt.background = 'dark'

vim.cmd.colorscheme("catppuccin")

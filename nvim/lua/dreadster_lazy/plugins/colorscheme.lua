return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        init = function() vim.cmd.colorscheme("catppuccin-mocha") end,
        opts = {
            transparent_background = true,
            integrations = {
                treesitter = true,
                cmp = true,
                gitsigns = true,
                lsp_saga = true,
                mason = true,
                notify = true,
                telescope = {enabled = true},
                dap = true,
                alpha = true,
                markdown = true,
                which_key = true,
                nvimtree = true,
                illuminate = true,
                lsp_trouble = true
            }
        }
    }
}

local utils = require("dreadster.utils")
if not utils.check_module_installed("crates") then return end

require("crates").setup({})

local cmp = require("cmp")

vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("CmpSourceCargo", {clear = true}),
    pattern = "Cargo.toml",
    callback = function()
        cmp.setup.buffer({sources = {{name = "crates"}}})

        local opts = {noremap = true, silent = true}
        local keymap = vim.api.nvim_buf_set_keymap
        keymap(0, 'n', '<F4>', "<cmd>lua require('crates').show_popup()<CR>",
               opts)
        keymap(0, 'n', 'cf',
               "<cmd>lua require('crates').show_features_popup()<CR>", opts)
        keymap(0, 'n', 'cr', "<cmd>lua require('crates').reload()<CR>", opts)
        keymap(0, 'n', 'cd', "<cmd>lua require('crates').open_crates_io()<CR>",
               opts)
        keymap(0, 'n', 'cu', "<cmd>lua require('crates').update_crate()<CR>",
               opts)
        keymap(0, 'n', 'cU',
               "<cmd>lua require('crates').update_all_crates()<CR>", opts)
    end
})

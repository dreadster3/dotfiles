local utils = require("dreadster.utils")
if not utils.check_module_installed("rust-tools") then return end

local rt = require("rust-tools")
local handlers = require("dreadster.lsp.handlers")

local _on_attach = function(client, bufnr)
    handlers.on_attach(client, bufnr)
    local opts = {noremap = true, silent = true}
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, 'n', 'K',
           "<cmd>lua require('rust-tools').hover_actions.hover_actions()<CR>",
           opts)
    keymap(bufnr, 'n', '<F4>',
           "<cmd>lua require('rust-tools').code_action_group.code_action_group()<CR>",
           opts)
end

vim.cmd([[
  augroup cargo_reload
    autocmd!
    autocmd BufWritePost Cargo.toml | lua require('crates').reload()
  augroup end
]])

rt.setup({server = {on_attach = _on_attach}})

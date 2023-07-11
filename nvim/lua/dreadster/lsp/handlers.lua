local utils = require("dreadster.utils")
if not utils.check_module_installed("cmp_nvim_lsp") then return end

local cmp_nvim_lsp = require("cmp_nvim_lsp")

local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    local signs = {
        {name = "DiagnosticSignError", text = ""},
        {name = "DiagnosticSignWarn", text = ""},
        {name = "DiagnosticSignHint", text = ""},
        {name = "DiagnosticSignInfo", text = ""}
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name,
                           {texthl = sign.name, text = sign.text, numhl = ""})
    end

    local config = {
        virtual_text = false, -- disable virtual text
        signs = {
            active = signs -- show signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = ""
        }
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                                                 vim.lsp.handlers.hover,
                                                 {border = "rounded"})

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
end

local function lsp_keymaps(bufnr)
    local opts = {noremap = true, silent = true}
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, 'n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, 'n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, 'n', 'gD', "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, 'n', 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, 'n', 'go', "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    keymap(bufnr, 'n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, 'n', '<C-k>', "<cmd>lua vim.lsp.buf.signature_help()<CR>",
           opts)
    keymap(bufnr, 'n', '<F2>', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    keymap(bufnr, 'n', '<F4>', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    keymap(bufnr, 'x', '<F4>', "<cmd>lua vim.lsp.buf.range_code_action()<CR>",
           opts)
    keymap(bufnr, 'n', 'gl', "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, 'n', '[d', "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    keymap(bufnr, 'n', ']d', "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

local function lspsaga_keymaps(bufnr)
    local opts = {noremap = true, silent = true}
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, 'n', 'K', ":Lspsaga hover_doc<CR>", opts)
    keymap(bufnr, 'n', 'gd', ":Lspsaga goto_definition<CR>", opts)
    keymap(bufnr, 'n', 'Gd', ":Lspsaga peek_definition<CR>", opts)
    keymap(bufnr, 'n', 'gD', "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, 'n', 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, 'n', 'go', ":Lspsaga goto_type_definition<CR>", opts)
    keymap(bufnr, 'n', 'gO', ":Lspsaga peek_type_definition<CR>", opts)
    keymap(bufnr, 'n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, 'n', 'gR', ":Lspsaga finder<CR>", opts)
    keymap(bufnr, 'n', '<C-k>', "<cmd>lua vim.lsp.buf.signature_help()<CR>",
           opts)
    keymap(bufnr, 'n', '<F2>', ":Lspsaga rename<CR>", opts)
    keymap(bufnr, 'n', '<F4>', ":Lspsaga code_action<CR>", opts)
    keymap(bufnr, 'x', '<F4>', "<cmd>lua vim.lsp.buf.range_code_action()<CR>",
           opts)
    keymap(bufnr, 'n', 'gl', ":Lspsaga show_cursor_diagnostics<CR>", opts)
    keymap(bufnr, 'n', 'gL', ":Lspsaga show_line_diagnostics<CR>", opts)
    keymap(bufnr, 'n', '[d', ":Lspsaga diagnostic_jump_next<CR>", opts)
    keymap(bufnr, 'n', ']d', ":Lspsaga diagnostic_jump_next<CR>", opts)
end

M.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "sumneko_lua" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if utils.check_module_installed("lspsaga") then
        lspsaga_keymaps(bufnr)
    else
        lsp_keymaps(bufnr)
    end

    if not utils.check_module_installed("illuminate") then return end

    require("illuminate").on_attach(client)
end

return M

local utils = require("dreadster.utils")
if not utils.check_module_installed("null-ls") then return end

local function addIfExecutable(list, command, value)
    if not vim.fn.executable(command) == 1 then
        vim.notify(command .. " not found.", vim.log.levels.WARN,
                   {title = "null-ls"})
        return
    end
    table.insert(list, value)
end

local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({timeout_ms = 2000, bufnr = bufnr})
end

local sources = {formatting.clang_format}

addIfExecutable(sources, "prettier", formatting.prettier)
addIfExecutable(sources, "csharpier", formatting.csharpier)
addIfExecutable(sources, "terraform", formatting.terraform_fmt)
addIfExecutable(sources, "rustfmt", formatting.rustfmt)
addIfExecutable(sources, "latexindent", formatting.latexindent)
addIfExecutable(sources, "eslint", diagnostics.eslint)
addIfExecutable(sources, "lua-format", formatting.lua_format)
addIfExecutable(sources, "clang-format", formatting.clang_format)

null_ls.setup({
    sources = sources,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    lsp_formatting(bufnr)
                end
            })
        end
    end
})

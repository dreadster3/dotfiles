return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        name = "null-ls",
        event = {"BufReadPre", "BufNewFile"},
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            local lsp_formatting = function(bufnr)
                if vim.g.skip_formatting then return end

                vim.lsp.buf.format({timeout_ms = 2000, bufnr = bufnr})
            end

            return {
                sources = {
                    formatting.prettier, formatting.csharpier,
                    formatting.terraform_fmt, formatting.rustfmt,
                    formatting.lua_format, formatting.clang_format,
                    formatting.autopep8, formatting.gofmt, formatting.rustywind,
                    diagnostics.eslint, diagnostics.tfsec
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr
                        })
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
            }
        end
    }
}

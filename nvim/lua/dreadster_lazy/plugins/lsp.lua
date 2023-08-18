return {
    {"folke/neodev.nvim", opts = {}}, {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        event = {"BufReadPost", "BufNewFile"},
        keys = {
            {
                "<leader>lr",
                function()
                    vim.notify("Lsp Restarted")
                    vim.cmd([[LspRestart]])
                end,
                desc = "Restart Lsp"
            }
        }
    }, {"williamboman/mason.nvim", name = "mason", opts = {}}, {
        "williamboman/mason-lspconfig.nvim",
        name = "mason-lspconfig",
        dependencies = {"mason", "ray-x/lsp_signature.nvim"},
        init = function()
            local signs = {
                {name = "DiagnosticSignError", text = ""},
                {name = "DiagnosticSignWarn", text = ""},
                {name = "DiagnosticSignHint", text = ""},
                {name = "DiagnosticSignInfo", text = ""}
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, {
                    texthl = sign.name,
                    text = sign.text,
                    numhl = ""
                })
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
        end,
        config = function(_, opts)
            local mason_lsp = require("mason-lspconfig")

            mason_lsp.setup(opts)

            local utils = require("dreadster_lazy.utils")
            local handlers = require("dreadster_lazy.utils.lsp_handlers")
            local capabilities = handlers.capabilities
            local on_attach = handlers.on_attach
            local on_publish_diagnostics =
                vim.lsp.handlers["textDocument/publishDiagnostics"]
            local cooldown = false

            mason_lsp.setup_handlers({
                function(server_name) -- default handler (optional)
                    vim.notify("Default")
                    local lspconfig = require("lspconfig")
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        handlers = {
                            ["textDocument/publishDiagnostics"] = function(_,
                                                                           result,
                                                                           ctx,
                                                                           config)
                                for idx, diag in ipairs(result.diagnostics) do
                                    for position, value in pairs(diag.range) do
                                        if value.character == -1 or value.line ==
                                            -1 then
                                            if position == "start" and
                                                not cooldown then
                                                vim.notify(diag.message,
                                                           vim.log.levels.WARN,
                                                           {
                                                    title = "Diagnostic"
                                                })
                                                cooldown = true;
                                                vim.defer_fn(function()
                                                    -- Make sure function is only called once a minute
                                                    -- to avoid notification spam
                                                    cooldown = false
                                                end, 60000)
                                            end
                                            table.remove(result.diagnostics, idx)
                                        end
                                    end
                                end

                                return on_publish_diagnostics(_, result, ctx,
                                                              config)
                            end
                        }
                    })
                end,
                ["lua_ls"] = function()
                    vim.notify("Lua")
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            Lua = {
                                diagnostics = {globals = {'vim'}},
                                workspace = {checkThirdParty = false}
                            }
                        }
                    })
                end,
                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        single_file_support = true
                    })
                end,
                ["rust_analyzer"] = function()
                    -- require('dreadster.lsp.rust_tools')
                end,
                ["grammarly"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.grammarly.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        filetypes = {"markdown", "text", "tex"}
                    })
                end,
                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    capabilities.offsetEncoding = "utf-8"
                    lspconfig.clangd.setup({
                        capabilities = capabilities,
                        on_attach = on_attach
                    })
                end,
                ["omnisharp"] = function()
                    local lspconfig = require("lspconfig")
                    local handler = vim.lsp.handlers["textDocument/definition"];

                    if utils.check_module_installed('omnisharp_extended') then
                        handler = require('omnisharp_extended').handler
                    end

                    lspconfig.omnisharp.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        handlers = {["textDocument/definition"] = handler},
                        enable_editorconfig_support = true,
                        enable_ms_build_load_projects_on_demand = false,
                        enable_roslyn_analyzers = false,
                        organize_imports_on_format = true,
                        enable_import_completion = true,
                        sdk_include_prereleases = true,
                        analyze_open_documents_only = false
                    })
                end
            })
        end,
        opts = {
            ensure_installed = {
                "lua_ls", "clangd", "cmake", "tsserver", "terraformls",
                "tflint", "pyright", "bashls"
            }
        }
    }, {
        "glepnir/lspsaga.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons", "treesitter"},
        opts = {
            ui = {
                border = "rounded",
                kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind()
            },
            outline = {layout = "float"}
        }
    }, {
        "Hoffs/omnisharp-extended-lsp.nvim",
        dependencies = {"lspconfig"},
        event = {"BufReadPost *.cs"}
    }, {
        "folke/neodev.nvim",
        event = {"BufReadPost *.lua"},
        dependencies = {"lspconfig"},
        opts = {}
    }, {"ray-x/go.nvim", event = {"BufReadPost *.go"}, opts = {}}
}

local utils = require("dreadster.utils")
if not utils.check_module_installed("mason-lspconfig") then return end

local mason_lsp = require("mason-lspconfig")

mason_lsp.setup({
    ensure_installed = {
        "lua_ls", "clangd", "cmake", "tsserver", "terraformls", "tflint",
        "pyright", "bashls"
    }
})

local lspconfig = require("lspconfig")
local handlers = require("dreadster.lsp.handlers")
local capabilities = handlers.capabilities
local on_attach = handlers.on_attach

mason_lsp.setup_handlers({
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach
        })
    end,

    ["lua_ls"] = function()
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
        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            single_file_support = true
        })
    end,

    ["rust_analyzer"] = function() require('dreadster.lsp.rust_tools') end,

    ["grammarly"] = function()
        lspconfig.grammarly.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {"markdown", "text", "tex"}
        })
    end
})

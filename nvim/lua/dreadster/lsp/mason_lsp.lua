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
local on_publish_diagnostics =
    vim.lsp.handlers["textDocument/publishDiagnostics"]
local cooldown = false

mason_lsp.setup_handlers({
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            handlers = {
                ["textDocument/publishDiagnostics"] = function(_, result, ctx,
                                                               config)
                    for idx, diag in ipairs(result.diagnostics) do
                        for position, value in pairs(diag.range) do
                            if value.character == -1 or value.line == -1 then
                                if position == "start" and not cooldown then
                                    vim.notify(diag.message,
                                               vim.log.levels.WARN,
                                               {title = "Diagnostic"})
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

                    return on_publish_diagnostics(_, result, ctx, config)
                end
            }
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
    end,
    ["clangd"] = function()
        capabilities.offsetEncoding = "utf-8"
        lspconfig.clangd.setup({
            capabilities = capabilities,
            on_attach = on_attach
        })
    end,
    ["omnisharp"] = function()
        local handler = vim.lsp.handlers["textDocument/definition"];

        if utils.check_module_installed('omnisharp_extended') then
            handler = require('omnisharp_extended').handler
        end

        lspconfig.omnisharp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            handlers = {["textDocument/definition"] = handler},
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            enable_editorconfig_support = true,

            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            enable_ms_build_load_projects_on_demand = false,

            -- Enables support for roslyn analyzers, code fixes and rulesets.
            enable_roslyn_analyzers = false,

            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            organize_imports_on_format = true,

            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            enable_import_completion = true,

            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            sdk_include_prereleases = true,

            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            analyze_open_documents_only = false
        })
    end
})

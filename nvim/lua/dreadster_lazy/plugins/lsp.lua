return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp"
        },
        name = "lspconfig",
        event = {"BufReadPre", "BufNewFile"},
        keys = {
            {
                "<leader>lr",
                function()
                    vim.notify("Lsp Restarted")
                    vim.cmd([[LspRestart]])
                end,
                desc = "Restart Lsp"
            }
        },
        opts = {
            diagnostics = {
                virtual_text = false, -- disable virtual text
                signs = {
                    active = {
                        {name = "DiagnosticSignError", text = ""},
                        {name = "DiagnosticSignWarn", text = ""},
                        {name = "DiagnosticSignHint", text = ""},
                        {name = "DiagnosticSignInfo", text = ""}
                    }
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
            },
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {globals = {'vim'}},
                            workspace = {checkThirdParty = false}
                        }
                    }
                },
                pyright = {single_file_support = true},
                clangd = {},
                omnisharp = {
                    enable_editorconfig_support = true,
                    enable_ms_build_load_projects_on_demand = false,
                    enable_roslyn_analyzers = false,
                    organize_imports_on_format = true,
                    enable_import_completion = true,
                    sdk_include_prereleases = true,
                    analyze_open_documents_only = false
                },
                rust_analyzer = {},
                terraformls = {},
                tflint = {}
            },
            setup = {
                clangd = function(_, opts)
                    opts.capabilities.offsetEncoding = "utf-8"
                end,
                omnisharp = function(_, opts)
                    local utils = require("dreadster_lazy.utils")
                    if utils.check_module_installed("omnisharp_extended") then
                        local handler = require("omnisharp_extended").handler
                        opts.handlers = {["textDocument/definition"] = handler}
                    end
                end
            }
        },
        config = function(_, opts)
            -- Diagnostics
            for _, sign in ipairs(opts.diagnostics.signs.active) do
                vim.fn.sign_define(sign.name, {
                    texthl = sign.name,
                    text = sign.text,
                    numhl = ""
                })
            end

            vim.diagnostic.config(opts.diagnostics)

            local handlers = require("dreadster_lazy.utils.lsp_handlers")

            handlers.on_attach()

            -- Servers
            local servers = opts.servers
            local has_cmp_nvim_lsp, cmp_nvim_lsp =
                pcall(require, "cmp_nvim_lsp")

            local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp
                                                         .protocol
                                                         .make_client_capabilities(),
                                                     has_cmp_nvim_lsp and
                                                         cmp_nvim_lsp.default_capabilities() or
                                                         {},
                                                     opts.capabilities or {})

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities or {})
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available thourgh mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require(
                                                    "mason-lspconfig.mappings.server").lspconfig_to_package)
            end

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or
                        not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({
                    ensure_installed = ensure_installed,
                    handlers = {setup}
                })
            end
        end
    }, {"williamboman/mason.nvim", name = "mason", opts = {}}, {
        "glepnir/lspsaga.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons", "treesitter"},
        event = {"LspAttach"},
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
    }, {"ray-x/go.nvim", event = {"BufReadPost *.go"}, opts = {}}, {
        "Saecki/crates.nvim",
        event = {"BufRead Cargo.toml"},
        init = function()
            vim.api.nvim_create_autocmd("BufReadPre", {
                group = vim.api.nvim_create_augroup("CmpSourceCargo",
                                                    {clear = true}),
                pattern = "Cargo.toml",
                callback = function()
                    local cmp = require("cmp")
                    cmp.setup.buffer({sources = {{name = "crates"}}})

                    local opts = {noremap = true, silent = true}
                    local keymap = vim.api.nvim_buf_set_keymap
                    keymap(0, 'n', '<F4>',
                           "<cmd>lua require('crates').show_popup()<CR>", opts)
                    keymap(0, 'n', 'cf',
                           "<cmd>lua require('crates').show_features_popup()<CR>",
                           opts)
                    keymap(0, 'n', 'cr',
                           "<cmd>lua require('crates').reload()<CR>", opts)
                    keymap(0, 'n', 'cd',
                           "<cmd>lua require('crates').open_crates_io()<CR>",
                           opts)
                    keymap(0, 'n', 'cu',
                           "<cmd>lua require('crates').update_crate()<CR>", opts)
                    keymap(0, 'n', 'cU',
                           "<cmd>lua require('crates').update_all_crates()<CR>",
                           opts)
                end
            })
        end,
        config = function(_, opts)
            require("crates").setup(opts)

            local cargo_reload_group = vim.api.nvim_create_augroup(
                                           "cargo_reload", {clear = true})
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = "Cargo.toml",
                group = cargo_reload_group,
                callback = function() require("crates").reload() end
            })
        end
    }, {
        "simrat39/rust-tools.nvim",
        dependencies = {"lspconfig"},
        event = "BufReadPre *.rs",
        opts = {}
    }
}

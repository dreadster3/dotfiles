return {
    {
        "nvim-tree/nvim-tree.lua",
        name = "nvimtree",
        lazy = false,
        dependencies = {"nvim-tree/nvim-web-devicons"},
        keys = {{"<leader>e", ":NvimTreeFocus<CR>", desc = "Focus nvim tree"}},
        opts = {
            disable_netrw = true,
            hijack_netrw = true,
            sync_root_with_cwd = true,
            actions = {change_dir = {enable = true, global = true}}
        }
    }, {
        "rcarriga/nvim-notify",
        name = "notify",
        lazy = false,
        init = function() vim.notify = require("notify") end,
        opts = {
            background_colour = "#000000",
            render = "compact",
            max_width = 50,
            top_down = false,
            max_height = 3
        }
    }, {
        "petertriho/nvim-scrollbar",
        name = "scrollbar",
        config = function(_, opts)
            require("scrollbar").setup(opts)
            require("scrollbar.handlers.gitsigns").setup()
        end,
        opts = {handlers = {cursor = false}}
    }, {
        "lewis6991/gitsigns.nvim",
        name = "gitsigns",
        opts = {current_line_blame = true}
    }, {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
        keys = {{"<leader>gl", ":TroubleToggle<CR>", desc = "Toggle trouble"}}
    }, {
        "j-hui/fidget.nvim",
        name = "fidget",
        event = "LspAttach",
        tag = "legacy",
        opts = {text = {spinner = "arc"}}
    }, {
        "akinsho/bufferline.nvim",
        name = "bufferline",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        event = "BufReadPost",
        keys = {
            {
                "˙",
                ":BufferLineCyclePrev<CR>",
                desc = "Cycle to previous buffer in buffer line"
            }, {
                "¬",
                ":BufferLineCycleNext<CR>",
                desc = "Cycle to next buffer in buffer line"
            }, {
                "<A-l>",
                ":BufferLineCycleNext<CR>",
                desc = "Cycle to next buffer in buffer line"
            }, {
                "<A-h>",
                ":BufferLineCyclePrev<CR>",
                desc = "Cycle to previous buffer in buffer line"
            }
        },
        opts = {
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center"
                    }
                }
            }
        }
    }, {
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        event = "BufReadPost",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        opts = {}
    }, {"levouh/tint.nvim", name = "tint", opts = {}}, {
        "kevinhwang91/rnvimr",
        name = "rnvimr",
        cmd = "RnvimrToggle",
        keys = {
            {"<C-e>", ":RnvimrToggle<CR>", desc = "Toggle ranger file explorer"},
            {
                "<C-r>",
                "<C-\\><C-n>:RnvimrResize<CR>",
                desc = "Resize ranger file explorer",
                mode = "t"
            }, {
                "<C-e>",
                "<C-\\><C-n>:RnvimrToggle<CR>",
                desc = "Resize ranger file explorer",
                mode = "t"
            }
        }
    }, {
        "goolord/alpha-nvim",
        event = "VimEnter",
        name = "alpha",
        opts = function(_, opts)
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]]
            }

            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file",
                                 ":Telescope find_files <CR>"),
                dashboard.button("e", "  New file",
                                 ":ene <BAR> startinsert <CR>"),
                dashboard.button("p", "  Find project",
                                 ":lua vim.cmd([[Telescope projects]])<CR>"),
                dashboard.button("r", "  Recently used files",
                                 ":Telescope oldfiles <CR>"),
                dashboard.button("t", "󱎸  Find text",
                                 ":Telescope live_grep <CR>"),
                dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
                dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
                dashboard.button("q", "  Quit Neovim", ":qa<CR>")
            }

            -- dashboard.opts.opts.noautocmd = true

            return dashboard
        end,
        config = function(_, dashboard)
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end
                })
            end

            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val =
                        "⚡ Neovim loaded " .. stats.count .. " plugins in " ..
                            ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end
            })
        end
    }
}

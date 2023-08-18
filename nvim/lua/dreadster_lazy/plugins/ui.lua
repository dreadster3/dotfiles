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
        event = "BufReadPre",
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
        event = "BufReadPre",
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
    }
}

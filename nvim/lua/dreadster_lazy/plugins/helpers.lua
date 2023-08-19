return {
    {
        "terrortylor/nvim-comment",
        name = "nvim_comment",
        dependencies = {"JoosepAlviste/nvim-ts-context-commentstring"},
        keys = {
            {"<C-/>", ":CommentToggle<CR>", desc = "Toggle comment for line"}, {
                "<C-/>",
                ":'<,'>CommentToggle<CR>",
                mode = "v",
                desc = "Toggle comment for line"
            }
        },
        opts = {
            hook = function()
                require('ts_context_commentstring.internal').update_commentstring(
                    {})
            end
        }
    }, {
        'windwp/nvim-autopairs',
        dependencies = {'windwp/nvim-ts-autotag'},
        event = {"InsertEnter"},
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {check_ts = true}
    }, {"folke/which-key.nvim", event = "VeryLazy", opts = {}},
    {"folke/todo-comments.nvim", event = "BufReadPre", opts = {}},
    {"RRethy/vim-illuminate", event = {"BufReadPost"}}
}

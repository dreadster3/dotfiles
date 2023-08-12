local utils = require("dreadster.utils")
if not utils.check_module_installed("nvim-treesitter") then return end

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'c', 'lua', 'typescript', 'tsx', 'html', 'java', 'cpp', 'c_sharp', 'css'
    },
    sync_install = false,
    auto_install = true,
    autotag = {
        enable = true,
        filetypes = {
            'html', 'javascript', 'typescript', 'javascriptreact',
            'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'xml',
            'php', 'markdown', 'glimmer', 'handlebars', 'hbs'
        }
    },
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true
    },
    indent = {enable = true},
    context_commentstring = {enable = true}
}

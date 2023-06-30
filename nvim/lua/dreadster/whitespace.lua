local utils = require('dreadster.utils')

if not utils.check_module_installed('whitespace-nvim') then return end

local whitespace = require('whitespace-nvim')

whitespace.setup({
    -- configuration options and their defaults

    -- `highlight` configures which highlight is used to display
    -- trailing whitespace
    highlight = 'DiffDelete',

    -- `ignored_filetypes` configures which filetypes to ignore when
    -- displaying trailing whitespace
    ignored_filetypes = {'TelescopePrompt', 'Trouble', 'help'},

    -- `ignore_terminal` configures whether to ignore terminal buffers
    ignore_terminal = true
})

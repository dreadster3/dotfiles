local utils = require("dreadster.utils")

if not utils.check_module_installed("notify") then return end

vim.notify = require("notify")

require("notify").setup({
    background_colour = "#000000",
    render = "compact",
    max_width = 50,
    top_down = false,
    max_height = 3
})

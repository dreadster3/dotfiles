local utils = require("dreadster.utils")
if not utils.check_module_installed("lspsaga") then return end

require("lspsaga").setup({
    ui = {border = "rounded"},
    outline = {layout = "float"}
})

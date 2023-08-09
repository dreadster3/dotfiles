local utils = require("dreadster.utils")
if not utils.check_module_installed("lspsaga") then return end

require("lspsaga").setup({
    ui = {
        border = "rounded",
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind()
    },
    outline = {layout = "float"}
})

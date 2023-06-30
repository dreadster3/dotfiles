local utils = require("dreadster.utils")
if not utils.check_module_installed("bufferline") then return end

require("bufferline").setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center"
            }
        }
    }
})

local utils = require("dreadster.utils")
if not utils.check_module_installed("scrollbar") then return end

require("scrollbar").setup({handlers = {cursor = false}})

require("scrollbar.handlers.gitsigns").setup()

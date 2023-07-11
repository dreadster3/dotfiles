local utils = require("dreadster.utils")
if not utils.check_module_installed("lsp_signature") then return end

require("lsp_signature").setup({})

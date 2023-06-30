local utils = require("dreadster.utils")
if not utils.check_module_installed("nvim-autopairs") then return end

require("nvim-autopairs").setup({})

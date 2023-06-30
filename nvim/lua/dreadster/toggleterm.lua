local utils = require("dreadster.utils")
if not utils.check_module_installed("toggleterm") then return end

require('toggleterm').setup({open_mapping = [[<c-\>]]})

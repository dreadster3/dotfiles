local utils = require("dreadster.utils")
if not utils.check_module_installed("tint") then return end

require('tint').setup({})

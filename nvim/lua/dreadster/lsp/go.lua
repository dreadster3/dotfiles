local utils = require("dreadster.utils")
if not utils.check_module_installed("go") then return end

require("go").setup()

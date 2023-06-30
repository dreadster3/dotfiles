local utils = require("dreadster.utils")
if not utils.check_module_installed("mason") then return end

local mason = require("mason")

mason.setup({})

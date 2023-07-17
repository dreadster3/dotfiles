local utils = require("dreadster.utils")
if not utils.check_module_installed("nvim_comment") then return end

local prehook = nil

if utils.check_module_installed("ts_context_commentstring") then
    prehook = function()
        require('ts_context_commentstring.internal').update_commentstring()
    end
end

require("nvim_comment").setup({hook = prehook})

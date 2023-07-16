local utils = require("dreadster.utils")
if not utils.check_module_installed("which-key") then return end

vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup({})

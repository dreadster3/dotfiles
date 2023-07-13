local utils = require("dreadster.utils")
if not utils.check_module_installed("template") then return end

local template = require('template')

template.author = "dreadster3"
template.email = "afonso.antunes@live.com.pt"
template.temp_dir = "/home/dreadster/.config/nvim/template"

local mappings = {
    typescript = {"function.ts"},
    cmake = {"VCMakeLists.txt"},
    text = {"conanfile.txt"}
}

local temp_table = {}

for filetype, filenames in pairs(mappings) do
    for _, filename in ipairs(filenames) do temp_table[filename] = filetype end
end

-- Add any template that filetype cannot be detected
vim.filetype.add({filename = temp_table})

local test = vim.filetype.match({filename = "function.ts"})
vim.notify(tostring(test), vim.log.levels.INFO, {title = "Filetype"})

local utils = require("dreadster.utils")
if not utils.check_module_installed("telescope") then return end

local telescope = require("telescope")

telescope.setup({
    defaults = {
        file_ignore_patterns = {"obj", "bin", "node_modules", "build", "target"},

        mappings = {n = {["q"] = require("telescope.actions").close}}
    },
    extensions = {}
})

telescope.load_extension('media_files')
telescope.load_extension('find_template')

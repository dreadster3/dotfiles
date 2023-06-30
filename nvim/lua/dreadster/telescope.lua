local utils = require("dreadster.utils")
if not utils.check_module_installed("telescope") then return end

local telescope = require("telescope")

telescope.setup({
    defaults = {
        file_ignore_patterns = {"obj", "bin", "node_modules", "build", "target"}
    },
    extensions = {}
})

telescope.load_extension('media_files')

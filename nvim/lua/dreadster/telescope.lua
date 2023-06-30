local utils = require("dreadster.utils")
if not utils.check_module_installed("telescope") then return end

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {"obj", "bin", "node_modules", "build", "target"}
    },
    extensions = {
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        }
    }
})

require('telescope').load_extension('media_files')

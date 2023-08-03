local utils = require("dreadster.utils")
if not utils.check_module_installed("telescope") then return end

local telescope = require("telescope")

telescope.setup({
    defaults = {
        file_ignore_patterns = {"obj", "bin", "node_modules", "build", "target"},
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8
            },
            vertical = {mirror = false},
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120
        },
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},

        mappings = {n = {["q"] = require("telescope.actions").close}}
    },
    extensions = {}
})

telescope.load_extension('media_files')
telescope.load_extension('find_template')

local utils = require("dreadster.utils")
if not utils.check_module_installed("nvim-web-devicons") then return end

require("nvim-web-devicons").setup {
    override_by_filename = {
        [".prettierrc"] = {icon = "󰬗", color = "#7242ED", name = "Prettier"}
    }
}

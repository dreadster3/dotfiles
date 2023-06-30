local utils = require("dreadster.utils")
if not utils.check_module_installed("tasks") then return end

local path = require("plenary.path")

require("tasks").setup({
    default_params = {
        cmake = {
            cmd = "cmake",
            build_dir = tostring(path:new('{cwd}', 'build', '{os}-{build_type}')),
            build_type = "debug",
            args = {configure = {"-G", "Unix Makefiles"}}
        },
        conan = {cmd = "conan", build_type = "debug"}
    },
    quickfix = {only_on_error = true}
})

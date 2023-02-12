local utils = require("dreadster.utils")
local module_name = "tasks"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

local path = require("plenary.path")

require("tasks").setup({
	default_params = {
		cmake = {
			cmd = "cmake",
			build_dir = tostring(path:new('{cwd}', 'build', '{os}-{build_type}')),
			build_type = "debug",
			args = {
				configure = {"-G", "Unix Makefiles"}
			}
		},
		conan = {
			cmd = "conan",
			build_type = "debug"
		}
	},
	quickfix = {
		only_on_error = true
	}
})

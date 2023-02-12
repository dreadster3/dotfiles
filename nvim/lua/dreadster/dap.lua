local utils = require("dreadster.utils")
local module_name = "dap.ext.vscode"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

local path = require("plenary.path")
local cwd = vim.loop.cwd()

local pathOrder = {
	path:new(cwd, "launch.json"),
	path:new(cwd, ".vscode", "launch.json")
}

local debuggers = {
	cppdbg = {"cpp" , "c"}
}

for _, p in ipairs(pathOrder) do
	if p:exists() then
		vim.notify("Loaded: " .. p.filename)

		require("dap.ext.vscode").load_launchjs(p.filename, debuggers)
		break
	end
end



-- require("dap.ext.vscode").load_launchjs()

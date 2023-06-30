local M = {}

M.log_module_failed_load = function(module_name)
    vim.notify("Failed to load module", vim.log.levels.WARN,
               {title = module_name})
end

M.check_module_installed = function(module_name)
    local ok, _ = pcall(require, module_name)

    if not ok then
        M.log_module_failed_load(module_name)
        return false
    end

    return true
end

return M

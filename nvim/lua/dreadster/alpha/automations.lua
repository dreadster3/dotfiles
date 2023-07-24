local utils = require("dreadster.utils")

local M = {}

local open_nvim_tree = function()
    if not utils.check_module_installed("nvim-tree") then return end
    require("nvim-tree.api").tree.open()
end

local change_working_directory = function(prompt_bufnr, prompt)
    local project = require("project_nvim.project")
    local state = require("telescope.actions.state")
    local actions = require("telescope.actions")
    local selected_entry = state.get_selected_entry()
    if selected_entry == nil then
        actions.close(prompt_bufnr)
        return
    end
    local project_path = selected_entry.value
    if prompt == true then
        actions._close(prompt_bufnr, true)
    else
        actions.close(prompt_bufnr)
    end
    local cd_successful = project.set_pwd(project_path, "telescope")
    return project_path, cd_successful
end

M.open_configuration = function()
    local vimrc = vim.fn.stdpath("config")

    vim.cmd.cd(vimrc)

    open_nvim_tree()

    vim.cmd.edit(vimrc .. "/init.lua")
end

M.find_projects = function()
    if not utils.check_module_installed("telescope") then return end
    local telescope = require('telescope');
    local telescope_actions = require("telescope.actions")

    local telescope_projects = telescope.extensions.projects;

    local opts = {
        prompt_title = "Recent Projects",
        previewer = false,
        attach_mappings = function(prompt_bufnr, map)
            local on_project_selected = function()
                change_working_directory(prompt_bufnr)
                open_nvim_tree()
            end
            telescope_actions.select_default:replace(on_project_selected)
            return true
        end
    }

    telescope_projects.projects(opts)
end

return M

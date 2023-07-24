local utils = require("dreadster.utils")
if not utils.check_module_installed("nvim-tree") then return end

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	sync_root_with_cwd = true,
	actions = {
		change_dir = {
			enable = true,
			global = true,
		}
	}

})

-- Start nvim tree
local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then return end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end

-- open the tree
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

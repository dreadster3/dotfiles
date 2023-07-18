local utils = require("dreadster.utils")
if not utils.check_module_installed("nvim-tree") then return end

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	sync_root_with_cwd = true,
	-- respect_buf_cwd = true,
	-- update_focused_file = {
	-- 	enable = true,
	-- 	update_root = false,
	-- 	ignore_list = {},
	-- }
})

-- Start nvim tree
local function open_nvim_tree(data)
	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not no_name and not directory then return end

	-- change to the directory
	if directory then
		vim.cmd.cd(data.file)
	else
		vim.cmd.cd(vim.fs.dirname(data.file))
	end

	-- open the tree
	require("nvim-tree.api").tree.open()
end

-- open the tree
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

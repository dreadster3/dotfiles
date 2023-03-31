local utils = require("dreadster.utils")
local module_name = "nvim-tree"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
})

-- Start nvim tree
local function open_nvim_tree(data)

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

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

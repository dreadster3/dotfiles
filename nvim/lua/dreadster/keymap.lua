local remap = require('dreadster.remap')
local nnoremap = remap.nnoremap
local tnoremap = remap.tnoremap
local vnoremap = remap.vnoremap

nnoremap("<leader>e", ":NvimTreeFocus<CR>")
nnoremap("<leader>f", ":Telescope find_files<CR>")
nnoremap('<leader>g', ':LazyGit<CR>')
nnoremap('<leader>s', ':w<CR>')
nnoremap('<leader>q', ':q<CR>')
nnoremap('<leader>sq', ':wq<CR>')
nnoremap('<leader>m', ':Telescope media_files<CR>')
nnoremap("<leader>md", ":MarkdownPreviewToggle<CR>")
nnoremap('<leader>lr', ":LspRestart<CR>:lua vim.notify('LSP Restarted')<CR>")
nnoremap('<leader>cb', ':Task start cmake build<CR>')
nnoremap('<leader>cg', ':Task start cmake configure<CR>')
nnoremap('<leader>ci', ':Task start conan install<CR>')
nnoremap('<leader>tfi', ':Task start terraform init<CR>')
nnoremap('<leader>tfv', ':Task start terraform validate<CR>')
nnoremap("<F5>", ":lua require('dap').continue()<CR>")
nnoremap("<F10>", ":lua require('dap').step_over()<CR>")
nnoremap("<F11>", ":lua require('dap').step_into()<CR>")
nnoremap("<F12>", ":lua require('dap').step_out()<CR>")
nnoremap("<leader>b", ":lua require('dap').toggle_breakpoint()<CR>")


nnoremap('<C-f>', ':RnvimrToggle<CR>')

tnoremap('<C-r>', '<C-\\><C-n>:RnvimrResize<CR>')
tnoremap('<C-f>', '<C-\\><C-n>:RnvimrToggle<CR>')

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  -- vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  -- vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

nnoremap('<C-/>', ":CommentToggle<CR>")
vnoremap('<C-/>', ":'<,'>CommentToggle<CR>")

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"



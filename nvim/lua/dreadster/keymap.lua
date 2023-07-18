local utils = require("dreadster.utils")
local remap = require('dreadster.remap')
local nnoremap = remap.nnoremap
local tnoremap = remap.tnoremap
local vnoremap = remap.vnoremap

-- NvimTree
nnoremap("<leader>e", ":NvimTreeFocus<CR>")

-- Bufferline
if utils.is_mac() == true then
	nnoremap("˙", ":BufferLineCyclePrev<CR>")
	nnoremap("¬", ":BufferLineCycleNext<CR>")
else
	nnoremap("<A-l>", ":BufferLineCycleNext<CR>")
	nnoremap("<A-h>", ":BufferLineCyclePrev<CR>")
end

-- Switch Windows
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Telescope
nnoremap("<leader>f", ":Telescope find_files<CR>")
nnoremap("<C-f>", ":Telescope live_grep<CR>")
nnoremap('<leader>fm', ':Telescope media_files<CR>')
nnoremap('<leader>fp', ':Telescope projects<CR>')

-- LazyGit
nnoremap('<leader>g', ':LazyGit<CR>')

-- Trouble
nnoremap('<leader>gl', ":TroubleToggle<CR>")

-- Helper
nnoremap('<leader>s', ':w<CR>')
nnoremap('<leader>q', ':q<CR>')
nnoremap("<C-a>", "ggvG")
nnoremap("<leader>cd", ":lua vim.cmd.cd(vim.fn.expand('%:p:h'))<CR>")

-- LSP
nnoremap('<leader>lr', ":LspRestart<CR>:lua vim.notify('LSP Restarted')<CR>")

-- DAP
nnoremap("<F5>", ":lua require('dap').continue()<CR>")
nnoremap("<F10>", ":lua require('dap').step_over()<CR>")
nnoremap("<F11>", ":lua require('dap').step_into()<CR>")
nnoremap("<F12>", ":lua require('dap').step_out()<CR>")
nnoremap("<leader>b", ":lua require('dap').toggle_breakpoint()<CR>")

-- Ranger
nnoremap('<C-e>', ':RnvimrToggle<CR>')
tnoremap('<C-r>', '<C-\\><C-n>:RnvimrResize<CR>')
tnoremap('<C-e>', '<C-\\><C-n>:RnvimrToggle<CR>')

-- Comment Toggle
nnoremap('<C-/>', ":CommentToggle<CR>")
vnoremap('<C-/>', ":'<,'>CommentToggle<CR>")

-- Terminal Toggle
function _G.set_terminal_keymaps()
	local opts = { noremap = true, buffer = 0 }

	if vim.bo.filetype ~= 'toggleterm' then return end

	-- vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

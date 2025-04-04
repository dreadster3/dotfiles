local nnoremap = function(lhs, rhs)
	vim.keymap.set("n", lhs, rhs, { silent = true, noremap = false })
end

-- Switch Windows
-- nnoremap("<C-h>", "<C-w>h")
-- nnoremap("<C-j>", "<C-w>j")
-- nnoremap("<C-k>", "<C-w>k")
-- nnoremap("<C-l>", "<C-w>l")

-- Helper
nnoremap("<leader>s", ":w<CR>")
nnoremap("<leader>q", ":q<CR>")
nnoremap("<leader>qa", ":qa<CR>")
nnoremap("<leader>Q", ":q!<CR>")
nnoremap("<leader>bd", require("dreadster.utils.ui").bufremove)
nnoremap("<C-a>", "ggVG")
nnoremap("<leader>cd", ":lua vim.cmd.cd(vim.fn.expand('%:p:h'))<CR>")

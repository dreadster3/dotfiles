local noremap = function(mode, lhs, rhs, opts)
    vim.keymap.set(mode or "n", lhs, rhs, vim.tbl_deep_extend("force", opts or {}, { silent = true, noremap = false }))
end

-- Switch Windows
-- nnoremap("<C-h>", "<C-w>h")
-- nnoremap("<C-j>", "<C-w>j")
-- nnoremap("<C-k>", "<C-w>k")
-- nnoremap("<C-l>", "<C-w>l")

-- Helper
noremap("n", "<leader>s", ":w<CR>")
noremap("n", "<leader>q", ":q<CR>")
noremap("n", "<leader>qa", ":qa<CR>")
noremap("n", "<leader>Q", ":q!<CR>")
noremap("n", "<leader>bd", require("dreadster.utils.ui").bufremove)
noremap("n", "<C-a>", "ggVG")
noremap("n", "<leader>cd", ":lua vim.cmd.cd(vim.fn.expand('%:p:h'))<CR>")

noremap("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
noremap("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
noremap("n", "∆", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
noremap("n", "˚", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
noremap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
noremap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
noremap("i", "∆", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
noremap("i", "˚", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

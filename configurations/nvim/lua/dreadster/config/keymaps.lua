local noremap = function(mode, lhs, rhs, opts)
	vim.keymap.set(mode or "n", lhs, rhs, vim.tbl_deep_extend("force", { silent = true, noremap = false }, opts or {}))
end

-- Switch Windows
-- nnoremap("<C-h>", "<C-w>h")
-- nnoremap("<C-j>", "<C-w>j")
-- nnoremap("<C-k>", "<C-w>k")
-- nnoremap("<C-l>", "<C-w>l")

-- Helper
noremap("n", "<leader>s", ":w<CR>", { desc = "Save file" })
noremap({ "n", "i", "x", "s" }, "<C-s>", ":w<CR>", { desc = "Save file" })
noremap("n", "<leader>q", ":q<CR>", { desc = "Quit buffer" })
noremap("n", "<leader>qq", ":qa<CR>", { desc = "Quit all" })
noremap("n", "<leader>Q", ":q!<CR>", { desc = "Force Quit buffer" })
noremap("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete buffer" })
noremap("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete other buffers" })
noremap("n", "<leader>cd", ":lua vim.cmd.cd(vim.fn.expand('%:p:h'))<CR>")

noremap({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	if vim.snippet then
		vim.snippet.stop()
	end
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Move lines
-- noremap("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
-- noremap("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
-- noremap("n", "∆", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
-- noremap("n", "˚", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
-- noremap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
-- noremap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
-- noremap("i", "∆", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
-- noremap("i", "˚", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- Commenting
noremap("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
noremap("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

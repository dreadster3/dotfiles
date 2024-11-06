local nnoremap = function(lhs, rhs)
	vim.keymap.set("n", lhs, rhs, { silent = true, noremap = false })
end

-- Switch Windows
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Helper
nnoremap("<leader>s", ":w<CR>")
nnoremap("<leader>q", ":q<CR>")
nnoremap("<leader>qa", ":qa<CR>")
nnoremap("<leader>Q", ":q!<CR>")
nnoremap("<leader>bd", require("dreadster.utils.ui").bufremove)
nnoremap("<C-a>", "ggVG")
nnoremap("<leader>cd", ":lua vim.cmd.cd(vim.fn.expand('%:p:h'))<CR>")

vim.g.http_proxy = vim.fn.getenv("http_proxy")
vim.g.https_proxy = vim.fn.getenv("https_proxy")

vim.api.nvim_create_user_command("ProxyToggle", function()
	local current_http_proxy = vim.fn.getenv("http_proxy")
	local current_https_proxy = vim.fn.getenv("https_proxy")

	if current_http_proxy == vim.NIL then
		vim.fn.setenv("http_proxy", vim.g.http_proxy)
	else
		vim.fn.setenv("http_proxy", "")
	end

	if current_https_proxy == vim.NIL then
		vim.fn.setenv("https_proxy", vim.g.https_proxy)
	else
		vim.fn.setenv("https_proxy", "")
	end
end, { nargs = 0 })

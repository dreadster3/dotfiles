local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local term_group = augroup("term", { clear = false })
au({ "BufEnter", "TermOpen" }, {
	group = term_group,
	pattern = "term://*",
	callback = function()
		vim.cmd("startinsert")
	end,
})

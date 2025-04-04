local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local term_group = augroup("term", { clear = false })
au("BufEnter", {
	group = term_group,
	pattern = "*",
	callback = function()
		local buftype = vim.opt.buftype:get()
		if buftype == "terminal" then
			vim.cmd("startinsert")
		end
	end,
})

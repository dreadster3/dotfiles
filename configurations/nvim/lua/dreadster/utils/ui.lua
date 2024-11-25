local M = {}

--- This function is taken directly from [LazyVim's UI utils](https://github.com/LazyVim/LazyVim/blob/a1c3ec4cd43fe61e3b614237a46ac92771191c81/lua/lazyvim/util/ui.lua#L228).
--- Besides some other nice features, this primarily prevents neo-tree from
--- taking up the whole screen after deleting a buffer.
--- (Thank you folke)
---@param buf number?
function M.bufremove(buf)
	buf = buf or 0
	buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

	if vim.bo.modified then
		local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
		if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
			return
		end
		if choice == 1 then -- Yes
			vim.cmd.write()
		end
	end

	for _, win in ipairs(vim.fn.win_findbuf(buf)) do
		vim.api.nvim_win_call(win, function()
			if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
				return
			end
			-- Try using alternate buffer
			local alt = vim.fn.bufnr("#")
			if alt ~= buf and vim.fn.buflisted(alt) == 1 then
				vim.api.nvim_win_set_buf(win, alt)
				return
			end

			-- Try using previous buffer
			local has_previous = pcall(vim.cmd, "bprevious")
			if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
				return
			end

			-- Create new listed buffer
			local new_buf = vim.api.nvim_create_buf(true, false)
			vim.api.nvim_win_set_buf(win, new_buf)
		end)
	end
	if vim.api.nvim_buf_is_valid(buf) then
		pcall(vim.cmd, "bdelete! " .. buf)
	end
end

--- Gets the catppuccin accent name
---@return string accent_name
function M.get_accent_name()
	local accent = vim.fn.getenv("CATPPUCCIN_ACCENT")

	if accent == "" or accent == vim.NIL then
		accent = "blue"
	end

	return accent
end

--- Gets the catppuccin accent color
---@return string accent_color
function M.get_accent_color()
	local accent_name = M.get_accent_name()

	local pallet = require("catppuccin.palettes").get_palette()

	return pallet[accent_name]
end

return M

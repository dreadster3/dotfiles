local M = {}

--- @param on_attach fun(client:vim.lsp.Client, buffer:number )
--- @param name? string
--- @return number
function M.on_attach(on_attach, name)
	return vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf or 0 --- @type number
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			if client and (not name or client.name == name) then
				on_attach(client, buffer)
			end
		end,
	})
end

---@alias lsp.Client.filter {id?: number, bufnr?: number, name?: string, method?: string, filter?:fun(client: vim.lsp.Client):boolean}
---@param opts? lsp.Client.filter
function M.get_clients(opts)
	local ret = vim.lsp.get_clients(opts)
	return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

return M

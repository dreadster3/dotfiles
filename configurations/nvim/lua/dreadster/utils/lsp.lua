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

return M

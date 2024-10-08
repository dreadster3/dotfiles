local utils = require("dreadster.utils")

if not utils.check_module_installed("cmp_nvim_lsp") then
	return
end

local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

local function lspsaga_keymaps(bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "<space>gd", ":Lspsaga peek_definition<CR>", opts)
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "go", ":Lspsaga goto_type_definition<CR>", opts)
	keymap(bufnr, "n", "<space>go", ":Lspsaga peek_type_definition<CR>", opts)
	keymap(bufnr, "n", "gr", ":Telescope lsp_references<CR>", opts)
	keymap(bufnr, "n", "gR", ":Lspsaga finder<CR>", opts)
	keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<F2>", ":Lspsaga rename<CR>", opts)
	keymap(bufnr, "n", "<F4>", ":Lspsaga code_action<CR>", opts)
	keymap(bufnr, "x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
	keymap(bufnr, "n", "gl", ":Lspsaga show_cursor_diagnostics<CR>", opts)
	keymap(bufnr, "n", "gll", ":Lspsaga show_line_diagnostics<CR>", opts)
	keymap(bufnr, "n", "glll", ":Lspsaga show_buf_diagnostics<CR>", opts)
	keymap(bufnr, "n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap(bufnr, "n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
end

local bounce = false

M.on_attach = function(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			local disabled_formatting = { "tsserver", "sumneko_lua", "omnisharp" }

			if client ~= nil and utils.is_in_table(disabled_formatting, client.name) then
				if not bounce then
					vim.notify("Disabled formatting for " .. client.name)
					bounce = true

					vim.defer_fn(function()
						bounce = false
					end, 5000)
				end

				client.server_capabilities.documentFormattingProvider = false
			end

			lspsaga_keymaps(buffer)

			if not utils.check_module_installed("illuminate") then
				return
			end

			require("illuminate").on_attach(client)
		end,
	})
end

return M

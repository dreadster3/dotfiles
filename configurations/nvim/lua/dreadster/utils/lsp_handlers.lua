local utils = require("dreadster.utils")

if not utils.check_module_installed("cmp_nvim_lsp") then
	return
end

local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

local function lspsaga_keymaps(bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap.set
	keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "<space>gd", ":Lspsaga peek_definition<CR>", opts)
	keymap("n", "gD", vim.lsp.buf.declaration, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, opts)
	keymap("n", "go", ":Lspsaga goto_type_definition<CR>", opts)
	keymap("n", "<space>go", ":Lspsaga peek_type_definition<CR>", opts)
	keymap("n", "gr", ":Telescope lsp_references<CR>", opts)
	keymap("n", "gR", ":Lspsaga finder<CR>", opts)
	keymap("n", "gs", vim.lsp.buf.signature_help, opts)
	keymap("n", "<F2>", ":Lspsaga rename<CR>", opts)
	keymap({ "n", "v" }, "<F4>", ":Lspsaga code_action<CR>", opts)
	keymap("n", "gl", ":Lspsaga show_cursor_diagnostics<CR>", opts)
	keymap("n", "gll", ":Lspsaga show_line_diagnostics<CR>", opts)
	keymap("n", "glll", ":Lspsaga show_buf_diagnostics<CR>", opts)
	keymap("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
end

M.on_attach = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			lspsaga_keymaps(args.buf)
		end,
	})
end

return M

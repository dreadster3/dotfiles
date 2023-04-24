local utils = require("dreadster.utils")
local module_name = "rust-tools"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

local rt = require("rust-tools")

local _on_attach = function(client, bufnr)
	local bufopts = { noremap=true, silent=true, buffer=bufnr }

	vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<F4>', rt.code_action_group.code_action_group, bufopts)
	vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
end

rt.setup({
  server = {
    on_attach = function(_, bufnr)
		_on_attach(_, bufnr)
    end,
  },
})

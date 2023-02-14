local utils = require("dreadster.utils")
local module_name = "mason-lspconfig"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

local mason_lsp = require("mason-lspconfig")

mason_lsp.setup({
	ensure_installed = {
		"lua_ls",
		"clangd",
		"cmake",
		"tsserver",
		"terraformls",
		"tflint",
		"pyright",
		"bashls"
	}
})

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap=true, silent=true, buffer=bufnr }

	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('x', '<F4>', vim.lsp.buf.range_code_action, bufopts)
	vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
end

mason_lsp.setup_handlers({
	function (server_name) -- default handler (optional)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			flags = lsp_flags
		})
	end,

	["lua_ls"] = function ()
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' }
					},
				}
			}
		})
	end,

	["pyright"] = function ()
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			single_file_support = true
		})
	end
})


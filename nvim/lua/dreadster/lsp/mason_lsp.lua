local utils = require("dreadster.utils")
if not utils.check_module_installed("mason-lspconfig") then return end

local mason_lsp = require("mason-lspconfig")

mason_lsp.setup({
	ensure_installed = {
		"lua_ls", "clangd", "cmake", "tsserver", "terraformls", "tflint",
		"pyright", "bashls"
	}
})

local lspconfig = require("lspconfig")
local handlers = require("dreadster.lsp.handlers")
local capabilities = handlers.capabilities
local on_attach = handlers.on_attach
local on_publish_diagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]
local cooldown = false

mason_lsp.setup_handlers({
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			handlers = {
				["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
					for idx, diag in ipairs(result.diagnostics) do
						for position, value in pairs(diag.range) do
							if value.character == -1 or value.line == -1 then
								if position == "start" and not cooldown then
									vim.notify(diag.message, vim.log.levels.WARN, {
										title = "Diagnostic"
									})
									cooldown = true;
									vim.defer_fn(function()
										-- Make sure function is only called once a minute
										-- to avoid notification spam
										cooldown = false
									end, 60000)
								end
								table.remove(result.diagnostics, idx)
							end
						end
					end

					return on_publish_diagnostics(_, result, ctx, config)
				end
			}
		})
	end,
	["lua_ls"]        = function()
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { 'vim' } },
					workspace = { checkThirdParty = false }
				}
			}
		})
	end,
	["pyright"]       = function()
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			single_file_support = true
		})
	end,
	["rust_analyzer"] = function() require('dreadster.lsp.rust_tools') end,
	["grammarly"]     = function()
		lspconfig.grammarly.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "markdown", "text", "tex" }
		})
	end,
	["clangd"]        = function()
		capabilities.offsetEncoding = "utf-8"
		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end
})

return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		name = "null-ls",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = function()
			local utils = require("dreadster.utils")
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			local lsp_formatting = function(bufnr)
				if vim.g.skip_formatting then
					return
				end

				vim.lsp.buf.format({ timeout_ms = 2000, bufnr = bufnr })
			end
			local sources = {
				formatting.prettier.with({ extra_filetypes = { "astro" } }),
				formatting.djhtml,
				formatting.csharpier,
				formatting.terraform_fmt,
				formatting.rustfmt,
				formatting.stylua,
				formatting.clang_format,
				formatting.taplo,
				formatting.goimports,
				formatting.rustywind,
				formatting.nixfmt,
				formatting.beautysh,
				formatting.latexindent,
				formatting.buf,
				diagnostics.tfsec,

				-- Python
				formatting.ruff.with({
					generator_opts = {
						command = "ruff",
						args = { "format", "-n", "--stdin-filename", "$FILENAME", "-" },
						to_stdin = true,
					},
				}),
				formatting.ruff.with({
					generator_opts = {
						command = "ruff",
						args = { "check", "--fix", "-n", "--stdin-filename", "$FILENAME", "-" },
						to_stdin = true,
					},
				}),
				diagnostics.ruff,
				diagnostics.mypy,
			}

			return {
				sources = utils.filter_sources(sources),
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
								lsp_formatting(bufnr)
							end,
						})
					end
				end,
			}
		end,
	},
}

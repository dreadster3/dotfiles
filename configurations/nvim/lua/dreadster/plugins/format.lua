return {
	{
		"stevearc/conform.nvim",
		name = "conform",
		dependencies = { "mason" },
		cmd = "ConformInfo",
		event = { "BufWritePre" },
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				terraform = { "terraform_fmt" },
				nix = { "nixfmt" },
				sh = { "beautysh" },
				json = { "prettier" },
				markdown = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		name = "nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- Event to trigger linters
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {
				lua = { "luacheck" },
				python = { "ruff", "mypy" },
				rust = { "clippy" },
				terraform = { "tflint", "trivy" },
				go = { "staticcheck", "trivy", "nilaway" },
				["*"] = { "typos" },
			},
			linters = {
				luacheck = {
					args_prepend = { "--globals", "vim" },
				},
				staticcheck = {
					cmd = "staticcheck",
					args = { "-f", "json", "./..." },
					append_fname = false,
				},
				nilaway = {
					cmd = "nilaway",
					args = { "-json", "-pretty-print=false", "./..." },
					append_fname = false,
					stdin = false,
					stream = "stdout",
					ignore_exitcode = true,
					parser = function(output, bufnr)
						local diagnostics = {}
						local decoded = vim.json.decode(output)
						local bufname = vim.api.nvim_buf_get_name(bufnr)

						for _, nilaway in pairs(decoded) do
							local messages = nilaway.nilaway
							for _, result in ipairs(messages) do
								local position_str = result.posn
								local splits = vim.split(position_str, ":")
								local filename = splits[1]
								local row = tonumber(splits[2]) - 1
								local column = tonumber(splits[3]) - 1
								local message = result.message

								if filename ~= bufname then
									break
								end

								table.insert(diagnostics, {
									lnum = row,
									col = column,
									end_col = column,
									end_lnum = row,
									severity = vim.diagnostic.severity.WARN,
									message = message,
								})
							end
						end

						return diagnostics
					end,
				},
			},
		},
		config = function(_, opts)
			local lint = require("lint")

			---Function to prevent repeated calls
			---@param ms number the time to wait between calls
			---@param fn function the function to call
			---@return function
			local debounce = function(ms, fn)
				local timer = vim.uv.new_timer()
				return function(...)
					local argv = { ... }
					timer:start(ms, 0, function()
						timer:stop()
						vim.schedule_wrap(fn)(unpack(argv))
					end)
				end
			end

			for name, linter in pairs(opts.linters) do
				if type(linter) == "table" and type(lint.linters[name]) == "table" then
					lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
					if type(linter.args_prepend) == "table" then
						lint.linters[name].args = lint.linters[name].args or {}
						vim.list_extend(lint.linters[name].args, linter.args_prepend)
					end
				else
					lint.linters[name] = linter
				end
			end

			local linters_by_ft = {}
			for ft, linters in pairs(opts.linters_by_ft) do
				linters_by_ft[ft] = {}
				for _, linter in ipairs(linters) do
					if vim.fn.executable(lint.linters[linter].cmd) == 1 then
						vim.list_extend(linters_by_ft[ft], { linter })
					else
						vim.notify("Linter " .. linter .. " not found.", vim.log.levels.WARN)
					end
				end
			end

			lint.linters_by_ft = linters_by_ft
			vim.api.nvim_create_autocmd(opts.events, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = debounce(100, function()
					if vim.opt_local.modifiable:get() then
						lint.try_lint()
					end
				end),
			})

			vim.api.nvim_create_user_command("LintInfo", function()
				print(vim.inspect(lint.get_running()))
			end, {})
		end,
	},
}

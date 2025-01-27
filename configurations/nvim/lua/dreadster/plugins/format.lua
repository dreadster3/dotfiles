return {
	{
		"stevearc/conform.nvim",
		name = "conform",
		dependencies = { "mason" },
		cmd = "ConformInfo",
		event = { "BufWritePre" },
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
				terraform = { "trivy", "tflint" },
				["*"] = { "typos" },
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

			lint.linters_by_ft = opts.linters_by_ft
			vim.api.nvim_create_autocmd(opts.events, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = debounce(100, function()
					require("lint").try_lint()
				end),
			})
		end,
	},
}

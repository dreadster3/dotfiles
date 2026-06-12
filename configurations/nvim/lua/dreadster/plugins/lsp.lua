return {
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		version = "*",
		dependencies = {
			"mason",
			"folke/snacks.nvim",
			{
				"mason-org/mason-lspconfig.nvim",
				version = "*",
			},
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },
		keys = {},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
			},
			inlay_hints = {
				enabled = true,
				exclude = {},
			},
			codelens = {
				enabled = false,
				exclude = {},
			},
			folds = {
				enabled = true,
				exclude = {},
			},
			setup = {},
			servers = {
				["*"] = {
                    -- stylua: ignore
					keys = {
                        { "gd",          function() Snacks.picker.lsp_definitions() end,          desc = "Goto Definition" },
                        { "gD",          function() Snacks.picker.lsp_declarations() end,         desc = "Goto Declaration" },
                        { "gr",          function() Snacks.picker.lsp_references() end,           desc = "References", nowait = true},
                        { "gI",          function() Snacks.picker.lsp_implementations() end,      desc = "Goto Implementation" },
                        { "gy",          function() Snacks.picker.lsp_type_definitions() end,     desc = "Goto T[y]pe Definition" },
                        { "gai",         function() Snacks.picker.lsp_incoming_calls() end,       desc = "C[a]lls Incoming" },
                        { "gao",         function() Snacks.picker.lsp_outgoing_calls() end,       desc = "C[a]lls Outgoing" },
                        { "K",           function() vim.lsp.buf.hover() end,                      desc = "Hover" },
                        { "gK",          function() return vim.lsp.buf.signature_help() end,      desc = "Signature Help", has = "signatureHelp" },
                        { "<c-k>",       function() return vim.lsp.buf.signature_help() end,      desc = "Signature Help", mode = "i", has = "signatureHelp" },
                        { "<leader>cd",  function() vim.diagnostic.open_float() end,              desc = "Line Diagnostics", mode = "n" },
                        { "<leader>ca",  function() vim.lsp.buf.code_action() end,                desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
                        { "<leader>cc",  function() vim.lsp.codelens.run() end,                   desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
                        { "<leader>cr",  function() vim.lsp.buf.rename() end,                     desc = "Rename", has = "rename" },
                        { "<leader>cR",  function() Snacks.rename.rename_file() end,              desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
                        { "]]",          function() Snacks.words.jump(vim.v.count1) end,   desc = "Next Reference", has = "documentHighlight", cond = function() return Snacks.words.is_enabled() end },
                        { "[[",          function() Snacks.words.jump(-vim.v.count1) end,  desc = "Prev Reference", has = "documentHighlight",  cond = function() return Snacks.words.is_enabled() end },
                    },
					capabilities = {
						workspace = {
							fileOperations = {
								didRename = true,
								willRename = true,
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			-- Keymaps
			local names = vim.tbl_keys(opts.servers) ---@type string[]
			table.sort(names)
			for _, server in ipairs(names) do
				local server_opts = opts.servers[server]
				if type(server_opts) == "table" and server_opts.keys then
					require("dreadster.utils.lsp").set({ name = server ~= "*" and server or nil }, server_opts.keys)
				end
			end

			-- Diagnostics
			if type(opts.diagnostics.signs) ~= "boolean" then
				for severity, icon in pairs(opts.diagnostics.signs.text) do
					local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
					name = "DiagnosticSign" .. name
					vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
				end
			end

			-- diagnostics
			if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
				opts.diagnostics.virtual_text.prefix = function(diagnostic)
					local icons = opts.diagnostics.signs.text
					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
							return icon
						end
					end
					return "●"
				end
			end
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			-- inlay hints
			if opts.inlay_hints.enabled then
				Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
					if
						vim.api.nvim_buf_is_valid(buffer)
						and vim.bo[buffer].buftype == ""
						and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
					then
						vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
					end
				end)
			end

			if opts.codelens.enabled then
				Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
					if
						vim.api.nvim_buf_is_valid(buffer)
						and vim.bo[buffer].buftype == ""
						and not vim.tbl_contains(opts.codelens.exclude, vim.bo[buffer].filetype)
					then
						vim.lsp.codelens.enable(true, {
							bufnr = buffer,
						})
					end
				end)
			end

			if opts.folds.enabled then
				Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function(buffer)
					if
						vim.api.nvim_buf_is_valid(buffer)
						and vim.bo[buffer].buftype == ""
						and not vim.tbl_contains(opts.folds.exclude, vim.bo[buffer].filetype)
					then
						local windows = vim.fn.win_findbuf(buffer)
						for _, win in ipairs(windows) do
							vim.api.nvim_set_option_value(
								"foldexpr",
								"v:lua.vim.lsp.foldexpr()",
								{ scope = "local", win = win }
							)
						end
					end
				end)
			end

			if opts.servers["*"] then
				vim.lsp.config("*", opts.servers["*"])
			end

			-- Servers
			local servers = opts.servers

			-- get all the servers that are available thourgh mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mlsp_servers = {}
			if have_mason then
				all_mlsp_servers =
					vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
			end
			local mason_exclude = {} ---@type string[]

			---@return boolean? exclude automatic setup
			local function configure(server)
				if server == "*" then
					return false
				end
				local sopts = servers[server]
				sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts

				if sopts.enabled == false then
					mason_exclude[#mason_exclude + 1] = server
					return
				end

				local use_mason = sopts.mason ~= false and vim.tbl_contains(all_mlsp_servers, server)
				local setup = opts.setup[server] or opts.setup["*"]
				if setup and setup(server, sopts) then
					mason_exclude[#mason_exclude + 1] = server
				else
					vim.lsp.config(server, sopts) -- configure the server
					if not use_mason then
						vim.lsp.enable(server)
					end
				end
				return use_mason
			end

			local install = vim.tbl_filter(configure, vim.tbl_keys(servers))
			if have_mason then
				mlsp.setup({
					ensure_installed = install,
					automatic_enable = { exclude = mason_exclude },
				})
			end
		end,
	},
	{
		"mason-org/mason.nvim",
		name = "mason",
		build = ":MasonUpdate",
		version = "*",
		opts = {},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		event = { "BufReadPre", "BufNewFile" },
		name = "refactoring",
		dependencies = { "lewis6991/async.nvim" },
		main = "refactoring",
        -- stylua: ignore
		keys = {
			{ "<leader>r", "", desc = "+refactor", mode = { "n", "x" } },
			{ "<leader>rs", function() return require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "Select Refactor" },
			{ "<leader>ri", function() return require("refactoring").inline_var() end, mode = { "n", "x" }, desc = "Inline Variable", expr = true },
			{ "<leader>rP", function() return require("refactoring.debug").print_loc({ output_location = "below" }) end, desc = "Debug Print Location", expr = true },
			{ "<leader>rp", function() return require("refactoring.debug").print_var({ output_location = "below" }) .. "iw" end, mode = { "n", "x" }, desc = "Debug Print Variable", expr = true },
			{ "<leader>rc", function() return require("refactoring.debug").cleanup({ restore_view = true }) .. "ag" end, desc = "Debug Cleanup", expr = true },
			{ "<leader>rf", function() return require("refactoring").extract_func() end, mode = { "n", "x" }, desc = "Extract Function", expr = true },
			{ "<leader>rF", function() return require("refactoring").extract_func_to_file() end, mode = { "n", "x" }, desc = "Extract Function To File", expr = true },
			{ "<leader>rx", function() return require("refactoring").extract_var() end, mode = { "n", "x" }, desc = "Extract Variable", expr = true },
		},
		opts = {},
	},
}

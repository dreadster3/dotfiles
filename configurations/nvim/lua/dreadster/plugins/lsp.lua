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
				enabled = true,
				exclude = {},
			},
			setup = {},
			servers = {
				["*"] = {
                    -- stylua: ignore
					keys = {
                        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
                        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
                        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
                        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
                        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
                        { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
                        { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
                        { "K", function() vim.lsp.buf.hover() end, desc = "Hover" },
                        { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp" },
                        { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
                        { "<leader>cd", function() vim.diagnostic.open_float() end, mode = "n",  desc = "Line Diagnostics" },
                        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
                        { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
                        { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
                        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
                        { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight", desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
                        { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight", desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
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
		dependencies = { "nvim-lua/plenary.nvim" },
		branch = "1.0",
		main = "refactoring",
        -- stylua: ignore
		keys = {
			{ "<leader>r", "", desc = "+refactor", mode = { "n", "v" } },
			{ "<leader>rs", function() require("telescope").extensions.refactoring.refactors() end, mode = { "n", "x", "v" }, desc = "Refactor" },
			{ "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "v" }, desc = "Inline Variable" },
			{ "<leader>rb", function() require("refactoring").refactor("Extract Block") end, desc = "Extract Block" },
			{ "<leader>rf", function() require("refactoring").refactor("Extract Block To File") end, desc = "Extract Block To File" },
			{ "<leader>rP", function() require("refactoring").debug.printf({ below = false }) end, desc = "Debug Print" },
			{ "<leader>rp", function() require("refactoring").debug.print_var({ normal = true }) end, desc = "Debug Print Variable" },
			{ "<leader>rc", function() require("refactoring").debug.cleanup({}) end, desc = "Debug Cleanup" },
			{ "<leader>rf", function() require("refactoring").refactor("Extract Function") end, mode = "v", desc = "Extract Function" },
			{ "<leader>rF", function() require("refactoring").refactor("Extract Function To File") end, mode = "v", desc = "Extract Function To File" },
			{ "<leader>rx", function() require("refactoring").refactor("Extract Variable") end, mode = "v", desc = "Extract Variable" },
			{ "<leader>rp", function() require("refactoring").debug.print_var({}) end, mode = "v", desc = "Debug Print Variable" },
		},
		config = function(_, opts)
			require("refactoring").setup(opts)

			require("dreadster.utils.lazy").lazy_load_telescope_extension("refactoring")
		end,
		opts = {},
	},
}

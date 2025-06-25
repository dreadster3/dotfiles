return {
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		version = "*",
		dependencies = {
			"mason",
			{
				"mason-org/mason-lspconfig.nvim",
				version = "*",
			},
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>lr",
				function()
					vim.notify("Lsp Restarted")
					vim.cmd([[LspRestart]])
				end,
				desc = "Restart Lsp",
			},
		},
		opts = function()
			return {
				capabilities = {
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				},
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
				servers = {
					texlab = { mason = false },
					bashls = {},
					eslint = { mason = false, settings = { format = false } },
				},
				setup = {
					clangd = function(_, opts)
						opts.capabilities.offsetEncoding = "utf-8"
					end,
				},
			}
		end,
		config = function(_, opts)
			-- Diagnostics
			if type(opts.diagnostics.signs) ~= "boolean" then
				for severity, icon in pairs(opts.diagnostics.signs.text) do
					local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
					name = "DiagnosticSign" .. name
					vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
				end
			end

			vim.diagnostic.config(opts.diagnostics)

			require("dreadster.utils.lsp").on_attach(function(client, buffer)
				require("dreadster.utils.keymaps").on_attach(client, buffer)
			end)

			-- Enable inlay hints
			vim.lsp.inlay_hint.enable()

			-- Servers
			local servers = opts.servers
			local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities() or {},
				opts.capabilities or {}
			)

			-- get all the servers that are available thourgh mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers =
					vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
			end

			--- @param server string
			--- @return boolean isSetup Whether the server needs setup or not
			local function configure(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities or {}),
				}, servers[server] or {})

				if server_opts.enabled == false then
					return true
				end

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return true
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return true
					end
				end
				vim.lsp.config(server, server_opts)

				if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
					vim.lsp.enable(server)
					return true
				end

				return false
			end

			---@type string[]
			local exclude_automatic_enable = {}
			---@type string[]
			local ensure_installed = {} ---@type string[]
			for server, _ in pairs(servers) do
				if configure(server) then
					exclude_automatic_enable[#exclude_automatic_enable + 1] = server
				else
					ensure_installed[#ensure_installed + 1] = server
				end
			end

			if have_mason then
				mlsp.setup({
					automatic_enable = true,
					ensure_installed = ensure_installed,
				})
			end
		end,
	},
	{
		"mason-org/mason.nvim",
		name = "mason",
		version = "*",
		opts = {},
	},
	{
		"glepnir/lspsaga.nvim",
		dependencies = { "icons", "nvim-treesitter" },
		event = { "LspAttach" },
		opts = function()
			local keymaps = require("dreadster.utils.keymaps").get()
			table.insert(keymaps, { "gx", ":Lspsaga show_line_diagnostics<CR>", desc = "Show Line Diagnostics" })
			table.insert(keymaps, { "gxx", ":Lspsaga show_buf_diagnostics<CR>", desc = "Show Buffer Diagnostics" })
			table.insert(
				keymaps,
				{ "gxxx", ":Lspsaga show_workspace_diagnostics<CR>", desc = "Show Workspace Diagnostics" }
			)
			table.insert(keymaps, { "K", ":Lspsaga hover_doc<CR>", desc = "Lspsaga Hover Doc" })

			return {
				ui = {
					kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
				},
				outline = { layout = "float" },
			}
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		event = { "BufReadPre", "BufNewFile" },
		name = "refactoring",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter" },
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

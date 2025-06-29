return {
	{
		"lspconfig",
		optional = true,
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts or {}, {
				servers = {
					jsonls = {
						-- lazy-load schemastore when needed
						on_new_config = function(new_config)
							new_config.settings.json.schemas = new_config.settings.json.schemas or {}
							vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
						end,
						settings = {
							json = {
								format = {
									enable = true,
								},
								validate = { enable = true },
								schemas = require("schemastore").json.schemas(),
							},
						},
					},
				},
			})
		end,
	},
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false, -- last release is way too old
	},
	{
		"conform",
		optional = true,
		opts = {
			formatters_by_ft = {
				json = { "prettier" },
				jsonc = { "prettier" },
			},
		},
	},
}

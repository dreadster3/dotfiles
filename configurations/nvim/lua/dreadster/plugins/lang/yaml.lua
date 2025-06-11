return {
	{
		"lspconfig",
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts or {}, {
				servers = {
					yamlls = {
						-- Have to add this for yamlls to understand that we support line folding
						capabilities = {
							textDocument = {
								foldingRange = {
									dynamicRegistration = false,
									lineFoldingOnly = true,
								},
							},
						},
						settings = {
							redhat = { telemetry = { enabled = false } },
							yaml = {
								keyOrdering = false,
								format = {
									enable = true,
								},
								validate = true,
								schemaStore = {
									-- Must disable built-in schemaStore support to use
									-- schemas from SchemaStore.nvim plugin
									enable = false,
									-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
									url = "",
								},
								schemas = require("schemastore").yaml.schemas(),
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
		opts = {
			formatters_by_ft = {
				yaml = { "prettier" },
			},
		},
	},
}

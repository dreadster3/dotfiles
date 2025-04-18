return {
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
		dependencies = { "lspconfig" },
		event = { "BufReadPost *.cs" },
		ft = { "cs" },
	},
}

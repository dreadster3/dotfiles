return {
	{
		"lspconfig",
		optional = true,
		opts = {
			servers = {
				terraformls = {},
				tflint = {},
			},
		},
	},
	{
		"conform",
		optional = true,
		opts = {
			formatters_by_ft = {
				hcl = { "packer_fmt" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
			},
		},
	},
	{
		"nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				terraform = { "terraform_validate", "tflint", "trivy" },
				tf = { "terraform_validate", "tflint", "trivy" },
			},
		},
	},
}

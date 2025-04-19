return {
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
				terraform = { "tflint", "trivy" },
				tf = { "tflint", "trivy" },
			},
		},
	},
	{
		"telescope",
		optional = true,
		specs = {
			{
				"ANGkeith/telescope-terraform-doc.nvim",
				ft = { "terraform", "hcl" },
				config = function()
					require("dreadster.utils.lazy").lazy_load_telescope_extension("terraform_doc")
				end,
			},
		},
	},
}

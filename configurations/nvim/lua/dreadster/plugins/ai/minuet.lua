local is_minuet_enabled = function()
	local env_variable = vim.fn.getenv("NVIM_MINUET_ENABLED")

	if env_variable == vim.NIL then
		return not require("dreadster.utils").is_mac()
	end

	env_variable = env_variable:gsub("^%s+", ""):gsub("%s+$", "")

	local values = {
		["true"] = true,
		["yes"] = true,
		["1"] = true,
		["on"] = true,
	}

	return values[env_variable:lower()]
end
---@return string
local litellm_base_url = function()
	local value = vim.fn.getenv("LITELLM_BASE_URL")

	if value == vim.NIL then
		return "http://localhost"
	end

	return value
end
return {
	{
		"milanglacier/minuet-ai.nvim",
		name = "minuet",
		event = { "InsertEnter" },
		enabled = is_minuet_enabled,
		version = "*",
		opts = {
			provider = "openai_fim_compatible",
			throttle = 1000,
			debounce = 400,
			context_window = 8000,
			provider_options = {
				openai_fim_compatible = {
					api_key = "LITELLM_API_KEY",
					name = "LiteLLM",
					model = "codestral-latest",
					end_point = litellm_base_url() .. "/v1/completions",
					stream = true,
					optional = {
						cache = {
							["no-cache"] = true,
						},
					},
				},
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		name = "cmp",
		optional = true,
		dependencies = { "minuet" },
		opts = function(_, opts)
			-- minuet only self-triggers on ` @.([: by design; add alphanumerics
			-- so any typed char triggers it (cmp checks this per-source override first)
			local chars = { " ", "@", ".", "(", "[", ":" }
			for c = string.byte("a"), string.byte("z") do
				chars[#chars + 1] = string.char(c)
			end
			for c = string.byte("A"), string.byte("Z") do
				chars[#chars + 1] = string.char(c)
			end
			for c = string.byte("0"), string.byte("9") do
				chars[#chars + 1] = string.char(c)
			end

			-- appended last, NOT first: cmp's render loop bails while the first
			-- source is still fetching, so a first-position minuet would hold the
			-- menu closed until the LLM responds; minuet_first keeps entries on top
			table.insert(opts.sources, {
				name = "minuet",
				priority = 1100,
				group_index = 1,
				trigger_characters = chars,
			})

			opts.performance = vim.tbl_deep_extend("force", opts.performance or {}, {
				-- low: menu renders immediately from fast sources; minuet's streamed
				-- entries splice in as chunks arrive (stream=true), no need to wait
				fetching_timeout = 150,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		name = "lualine",
		optional = true,
		dependencies = { "minuet" },
		opts = function(_, opts)
			opts = vim.tbl_deep_extend("force", opts or {}, {
				sections = {
					lualine_x = {
						{
							require("minuet.lualine"),
						},
						"encoding",
						"fileformat",
						"filetype",
					},
				},
			})
			return opts
		end,
	},
}

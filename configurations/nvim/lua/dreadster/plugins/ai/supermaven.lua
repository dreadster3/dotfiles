local is_supermaven_enabled = function()
    local copilot_env = vim.fn.getenv("NVIM_SUPERMAVEN_ENABLED")

    if copilot_env == vim.NIL then
        return not require("dreadster.utils").is_mac()
    end

    copilot_env = copilot_env:gsub("^%s+", ""):gsub("%s+$", "")

    local values = {
        ["true"] = true,
        ["yes"] = true,
        ["1"] = true,
        ["on"] = true,
    }

    return values[copilot_env:lower()]
end
return {
    {
        "supermaven-inc/supermaven-nvim",
        commit = "07d20fce48a5629686aefb0a7cd4b25e33947d50",
        name = "supermaven",
        event = "InsertEnter",
        enabled = is_supermaven_enabled,
        opts = {
            disable_inline_completion = true,
        },
    },
    {
        "hrsh7th/nvim-cmp",
        optional = true,
        dependencies = { "supermaven" },
        opts = function(_, opts)
            table.insert(opts.sources, 1, {
                name = "supermaven",
                priority = 1100,
                group_index = 1,
            })
        end,
    },
}

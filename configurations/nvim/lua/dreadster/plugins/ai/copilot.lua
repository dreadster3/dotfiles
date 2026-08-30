local is_copilot_enabled = function()
    local copilot_env = vim.fn.getenv("NVIM_COPILOT_ENABLED")

    if copilot_env == vim.NIL then
        return require("dreadster.utils").is_mac()
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
        "zbirenbaum/copilot.lua",
        name = "copilot",
        version = "*",
        build = ":Copilot auth",
        enabled = is_copilot_enabled,
        cmd = { "Copilot" },
        event = { "BufReadPost" },
        opts = {
            panel = {
                enabled = false,
                keymap = { enable = false },
            },
            suggestion = {
                enabled = false,
            },
            filetypes = {
                yaml = true,
                markdown = true,
                help = true,
            },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        lazy = true,
        opts = {},
    },
    {
        "hrsh7th/nvim-cmp",
        optional = true,
        dependencies = { "zbirenbaum/copilot-cmp" },
        opts = function(_, opts)
            table.insert(opts.sources, 1, {
                name = "copilot",
                priority = 1100,
                group_index = 1,
            })
        end,
    },
}

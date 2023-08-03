local utils = require("dreadster.utils")
if not utils.check_module_installed("cmp") then return end

if not utils.check_module_installed("lspkind") then return end

local cmp = require("cmp")
local lspkind = require('lspkind')

local kind_icons = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Variable = "󰀫",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = " ",
    Misc = " "
}

cmp.setup({
    completion = {completeopt = 'menuone,noselect,noinsert'},
    window = {
        completion = {
            winhighlight = 'Normal:None,FloatBorder:None,CursorLine:PmenuSel,Search:None',
            border = "rounded"
        }
    },
    snippet = {
        expand = function(args)
            -- For `vsnip` user.
            -- vim.fn["vsnip#anonymous"](args.body)

            -- For `luasnip` user.
            if utils.check_module_installed("luasnip") then
                require("luasnip").lsp_expand(args.body)
            end

            -- For `ultisnips` user.
            -- vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i", "s"}),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then cmp.select_prev_item() end
        end, {"i", "s"})
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            symbol_map = kind_icons,

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, item)
                local menu_icon = {
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                    nvim_lsp_signature_help = "[LSP]"
                    -- nvim_lua = "[Lua]"
                }

                item.menu = menu_icon[entry.source.name]

                return item
            end
        })
    },
    sources = {
        -- tabnine completion? yayaya

        {name = "nvim_lsp"}, -- For vsnip user.
        -- { name = 'vsnip' },
        -- For luasnip user.
        {name = "luasnip"}, -- For ultisnips user.
        -- { name = 'ultisnips' },
        {name = "buffer"}, {name = "path"}
        -- { name = "nvim_lua" }
    }
})

local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local opts = {noremap = true, buffer = 0}
local nnoremap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, opts) end

local cpp_maps = {
    pattern = {"CMakeLists.txt", "conanfile.txt", "*.cpp", "*.hpp", "*.h"},
    keymaps = {
        {"<leader>cb", ":Task start cmake build<CR>"},
        {"<leader>cg", ":Task start cmake configure<CR>"},
        {"<leader>ci", ":Task start conan install<CR>"}
    }
}

local terraform_maps = {
    pattern = {"*.tf"},
    keymaps = {
        {"<leader>tfi", ":Task start terraform init<CR>"},
        {"<leader>tfv", ":Task start terraform validate<CR>"}
    }
}

local maps = {cpp_maps, terraform_maps}

local tasks_group = augroup("tasks", {clear = true})
for _, map in ipairs(maps) do
    au("BufEnter", {
        group = tasks_group,
        pattern = map.pattern,
        callback = function()
            for _, keymap in ipairs(map.keymaps) do
                nnoremap(keymap[1], keymap[2])
            end
        end
    })
end

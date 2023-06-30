local folder_path = "build/debug"

local function create_folder(on_exit)
    return function()
        vim.fn.jobstart("mkdir -p " .. folder_path,
                        {cwd = "./", on_exit = on_exit})
    end
end

local function conan_install(on_exit)
    return function()
        vim.fn.jobstart("conan install ../../",
                        {cwd = folder_path, on_exit = on_exit})
    end
end

local function conan_install_command() return create_folder(conan_install())(); end

vim.api.nvim_create_user_command("ConanInstall", conan_install_command,
                                 {nargs = "?"})

vim.g.cmake_default_config = "debug"
vim.g.cmake_build_dir_location = "./build"
vim.g.cmake_link_compile_commands = 1

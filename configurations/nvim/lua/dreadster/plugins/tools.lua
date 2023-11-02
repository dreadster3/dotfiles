return {
    {
        "nvim-telescope/telescope.nvim",
        name = "telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {"nvim-telescope/telescope-media-files.nvim"},
            "nvim-telescope/telescope-symbols.nvim", "project"
        },
        cmd = {"Telescope"},
        keys = {
            {"<leader>ff", ":Telescope find_files<CR>", desc = "Find files"},
            {"<C-f>", ":Telescope live_grep<CR>", desc = "Live grep"},
            {
                "<leader>fm",
                ":Telescope media_files<CR>",
                desc = "Find media files"
            }
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            telescope.load_extension("media_files")
        end,
        opts = function()
            local opts = {
                defaults = {
                    file_ignore_patterns = {
                        "obj", "bin", "node_modules", "build", "target"
                    },
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8
                        },
                        vertical = {mirror = false},
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120
                    },
                    borderchars = {
                        "─", "│", "─", "│", "╭", "╮", "╯", "╰"
                    },
                    mappings = {
                        n = {["q"] = require("telescope.actions").close}
                    }
                },
                extensions = {media_files = {find_cmd = "rg"}}
            }

            return opts
        end
    }, {
        "kdheepak/lazygit.nvim",
        name = "lazygit",
        dependencies = {"nvim-lua/plenary.nvim"},
        cmd = "LazyGit",
        keys = {{"<leader>g", "<CMD>LazyGit<CR>", desc = "Lanch lazygit"}}
    }, {
        "akinsho/toggleterm.nvim",
        dependencies = {"lualine"},
        name = "toggleterm",
        version = "*",
        init = function()
            -- Terminal Toggle
            function _G.set_terminal_keymaps()
                local opts = {noremap = true, buffer = 0}

                if vim.bo.filetype ~= 'toggleterm' then return end

                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
            end

            vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
        end,
        cmd = "ToggleTerm",
        keys = {{"<C-\\>", "<CMD>ToggleTerm<CR>", desc = "Toggle terminal"}},
        opts = {
            open_mapping = [[<c-\>]],
            persist_size = false,
            start_in_insert = true,
            persist_mode = false
        }
    }, {
        "iamcco/markdown-preview.nvim",
        name = "markdown-preview",
        version = "*",
        cmd = {"MarkdownPreviewToggle"},
        build = "cd app && npx --yes yarn install",
        ft = "markdown",
        keys = {
            {
                "<leader>md",
                "<CMD>MarkdownPreviewToggle<CR>",
                desc = "Toggle markdown preview"
            }
        }
    },
    {"hiphish/rainbow-delimiters.nvim", name = "rainbow", event = "BufReadPre"},
    {
        "glepnir/template.nvim",
        name = "template",
        cmd = {"Template"},
        init = function()
            local mappings = {
                typescript = {"function.ts"},
                cmake = {"VCMakeLists.txt"},
                text = {"conanfile.txt"},
                yaml = {"clangformat"}
            }

            local temp_table = {}

            for filetype, filenames in pairs(mappings) do
                for _, filename in ipairs(filenames) do
                    temp_table[filename] = filetype
                end
            end

            -- Add any template that filetype cannot be detected
            vim.filetype.add({filename = temp_table})
        end,
        config = function(_, opts)
            require("template").setup(opts)

            require("telescope").load_extension("find_template")
        end,
        opts = {
            author = "dreadster3",
            email = "afonso.antunes@live.com.pt",
            temp_dir = vim.fn.expand("$HOME/.config/nvim/template")
        }
    }, {
        "johnfrankmorgan/whitespace.nvim",
        name = "whitespace",
        event = {"BufReadPre", "BufNewFile"},
        cmd = {"WhitespaceTrim"},
        init = function()
            vim.api.nvim_create_user_command("WhitespaceTrim", function()
                require("whitespace").trim()
            end, {})
        end,
        opts = {
            highlight = 'DiffDelete',
            ignored_filetypes = {
                'TelescopePrompt', 'Trouble', 'help', "noice", "glow"
            },
            ignore_terminal = true
        }
    }, {
        "ahmedkhalf/project.nvim",
        name = "project",
        cmd = {"ProjectRoot", "Telescope"},
        event = {"User AlphaReady"},
        dependencies = {"telescope"},
        keys = {
            {
                "<leader>fp",
                function()
                    vim.schedule(function()
                        vim.cmd('Telescope projects')
                    end)
                end,
                desc = "Find projects"
            }
        },
        config = function(_, opts)
            local telescope = require("telescope")

            require("project_nvim").setup(opts)

            telescope.load_extension("projects")
        end,
        opts = {
            on_config_done = nil,
            manual_mode = true,
            detection_methods = {"pattern"},
            patterns = {
                ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile",
                "package.json"
            },
            show_hidden = false,
            silent_chdir = false,
            ignore_lsp = {},
            datapath = vim.fn.stdpath("data")
        }
    }, {
        "dreadster3/neovim-tasks",
        name = "tasks",
        cmd = "Task",
        dependencies = {"nvim-lua/plenary.nvim"},
        init = function()
            local augroup = vim.api.nvim_create_augroup
            local au = vim.api.nvim_create_autocmd
            local opts = {noremap = true, buffer = 0}
            local nnoremap = function(lhs, rhs)
                vim.keymap.set('n', lhs, rhs, opts)
            end

            local cpp_maps = {
                pattern = {
                    "CMakeLists.txt", "conanfile.txt", "*.cpp", "*.hpp", "*.h"
                },
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
        end,
        opts = function(_, opts)
            local path = require("plenary.path")
            return {
                default_params = {
                    cmake = {
                        cmd = "cmake",
                        build_dir = tostring(
                            path:new('{cwd}', 'build', '{os}-{build_type}')),
                        build_type = "Debug",
                        args = {configure = {"-G", "Unix Makefiles"}}
                    },
                    conan = {cmd = "conan", build_type = "Debug"}
                },
                quickfix = {only_on_error = true}
            }
        end
    }, {"danymat/neogen", name = "neogen", cmd = "Neogen", opts = {}}, {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        opts = {open_cmd = "noswapfile vnew"},
        -- stylua: ignore
        keys = {
            {
                "<leader>sr",
                function() require("spectre").toggle() end,
                desc = "Replace in files (Spectre)"
            }
        }
    }, {
        "cshuaimin/ssr.nvim",
        name = "ssr",
        keys = {
            {
                "<leader>sR",
                "<CMD>lua require('ssr').open()<CR>",
                desc = "Search and Replace"
            }
        },
        opts = {
            border = "rounded",
            min_width = 50,
            min_height = 5,
            max_width = 120,
            max_height = 25,
            keymaps = {
                close = "q",
                next_match = "n",
                prev_match = "N",
                replace_confirm = "<cr>",
                replace_all = "<leader><cr>"
            }
        }
    }, {
        "luckasRanarison/nvim-devdocs",
        name = "devdocs",
        dependencies = {"telescope", "nvim-lua/plenary.nvim", "treesitter"},
        cmd = {
            "DevdocsFetch", "DevdocsInstall", "DevdocsUninstall", "DevdocsOpen",
            "DevdocsOpenFloat", "DevdocsOpenCurrent", "DevdocsOpenCurrentFloat",
            "DevdocsUpdate", "DevdocsUpdateAll"
        },
        opts = {
            previewer_cmd = "glow",
            cmd_args = {"-s", "$HOME/.config/glow/mocha.json"}
        }
    }

}

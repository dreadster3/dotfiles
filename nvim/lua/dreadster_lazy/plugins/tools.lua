return {
    {
        "nvim-telescope/telescope.nvim",
        name = "telescope",
        dependencies = {
            "nvim-lua/plenary.nvim", {
                "nvim-telescope/telescope-media-files.nvim",
                dependencies = {"nvim-lua/popup.nvim"}
            }, "nvim-telescope/telescope-symbols.nvim", "project", "template"
        },
        cmd = {"Telescope"},
        keys = {
            {"<leader>ff", ":Telescope find_files<CR>", desc = "Find files"},
            {"<C-f>", ":Telescope live_grep<CR>", desc = "Live grep"},
            {
                "<leader>fm",
                ":Telescope media_files<CR>",
                desc = "Find media files"
            }, {"<leader>fp", ":Telescope projects<CR>", desc = "Find projects"}
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            telescope.load_extension("media_files")
            telescope.load_extension("find_template")
            telescope.load_extension("projects")
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
                extensions = {}
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
        name = "toggleterm",
        init = function()
            local opts = {noremap = true, buffer = 0}

            if vim.bo.filetype ~= 'toggleterm' then return end

            -- vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end,
        cmd = "ToggleTerm",
        keys = {{"<C-\\>", "<CMD>ToggleTerm<CR>", desc = "Toggle terminal"}},
        opts = {open_mapping = [[<c-\>]], persist_size = false}
    }, {
        "iamcco/markdown-preview.nvim",
        name = "markdown-preview",
        tag = "v0.0.10",
        cmd = {"MarkdownPreviewToggle"},
        build = "cd app && npm install",
        ft = "markdown",
        keys = {
            {
                "<leader>md",
                "<CMD>MarkdownPreviewToggle<CR>",
                desc = "Toggle markdown preview"
            }
        }
    },
    {"hiphish/rainbow-delimiters.nvim", name = "rainbow", event = "BufReadPost"},
    {
        "glepnir/template.nvim",
        name = "template",
        cmd = "Template",
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
        opts = {
            author = "dreadster3",
            email = "afonso.antunes@live.com.pt",
            temp_dir = "/home/dreadster/.config/nvim/template"
        }
    }, {
        "johnfrankmorgan/whitespace.nvim",
        name = "whitespace",
        opts = {
            -- configuration options and their defaults

            -- `highlight` configures which highlight is used to display
            -- trailing whitespace
            highlight = 'DiffDelete',

            -- `ignored_filetypes` configures which filetypes to ignore when
            -- displaying trailing whitespace
            ignored_filetypes = {'TelescopePrompt', 'Trouble', 'help'},

            -- `ignore_terminal` configures whether to ignore terminal buffers
            ignore_terminal = true
        }
    }, {
        "ahmedkhalf/project.nvim",
        name = "project",
        cmd = "ProjectRoot",
        config = function(_, opts) require("project_nvim").setup(opts) end,
        opts = {
            ---@usage set to false to disable project.nvim.
            --- This is on by default since it's currently the expected behavior.
            active = true,

            on_config_done = nil,

            ---@usage set to true to disable setting the current-woriking directory
            --- Manual mode doesn't automatically change your root directory, so you have
            --- the option to manually do so using `:ProjectRoot` command.
            manual_mode = true,

            ---@usage Methods of detecting the root directory
            --- Allowed values: **"lsp"** uses the native neovim lsp
            --- **"pattern"** uses vim-rooter like glob pattern matching. Here
            --- order matters: if one is not detected, the other is used as fallback. You
            --- can also delete or rearangne the detection methods.
            -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
            detection_methods = {"pattern"},

            ---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
            patterns = {
                ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile",
                "package.json"
            },

            ---@ Show hidden files in telescope when searching for files in a project
            show_hidden = false,

            ---@usage When set to false, you will get a message when project.nvim changes your directory.
            -- When set to false, you will get a message when project.nvim changes your directory.
            silent_chdir = false,

            ---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
            ignore_lsp = {},

            ---@type string
            ---@usage path to store the project history for use in telescope
            datapath = vim.fn.stdpath("data")
        }
    }, {
        "dreadster3/neovim-tasks",
        name = "tasks",
        cmd = "Task",
        dependencies = {"nvim-lua/plenary.nvim"},
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
    }
}

local fn = vim.fn
local utils = require('dreadster.utils')

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
if not utils.check_module_installed("packer") then return end

-- Have packer use a popup window
require('packer').init({
    display = {
        open_fn = function()
            return require("packer.util").float({border = "rounded"})
        end
    }
})

return require('packer').startup(function(use)
    -- Plugin Manager
    use 'wbthomason/packer.nvim'

    -- Theme
    use {"catppuccin/nvim", as = "catppuccin"}

    -- Syntax Highlight
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- Lsp
    use 'neovim/nvim-lspconfig'
    use {'onsails/lspkind-nvim'}
    use {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"}
    use 'folke/neodev.nvim'
    use {
        "glepnir/lspsaga.nvim",
        requires = {
            {"nvim-tree/nvim-web-devicons"}, {"nvim-treesitter/nvim-treesitter"}
        }
    }
    use 'ray-x/lsp_signature.nvim'
    use 'ray-x/go.nvim'

    -- Fix issue with go to definition omnisharp
    use 'Hoffs/omnisharp-extended-lsp.nvim'

    -- Diagnostic
    use 'folke/trouble.nvim'

    -- Completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use "github/copilot.vim"
    use 'lervag/vimtex'

    -- DAP
    use 'mfussenegger/nvim-dap'
    use {"rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap"}
    use {
        "jay-babu/mason-nvim-dap.nvim",
        requires = {"mfussenegger/nvim-dap", "williamboman/mason.nvim"}
    }

    -- Formatting
    use 'jose-elias-alvarez/null-ls.nvim'

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        tag = "*",
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use {
        'nvim-telescope/telescope-media-files.nvim',
        requires = {{'nvim-lua/popup.nvim'}}
    }

    use 'nvim-telescope/telescope-symbols.nvim'

    -- Git
    use 'kdheepak/lazygit.nvim'
    use 'lewis6991/gitsigns.nvim'

    -- File Explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons' -- optional, for file icons
        }
    }

    -- Notifications
    use 'rcarriga/nvim-notify'
    use {'j-hui/fidget.nvim', tag = "legacy"}

    -- Terminal
    use {"akinsho/toggleterm.nvim", tag = '*'}

    -- File Explorer
    use 'kevinhwang91/rnvimr'

    -- Automations
    use {'dreadster3/neovim-tasks', requires = "nvim-lua/plenary.nvim"}
    use 'glepnir/template.nvim'

    -- Utilities
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'nvim-tree/nvim-web-devicons', opt = true}
    }

    -- Dashboard
    use {'goolord/alpha-nvim'}

    -- Rust tools
    use 'simrat39/rust-tools.nvim'
    use {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = {'nvim-lua/plenary.nvim'}
    }

    -- Comments
    use 'terrortylor/nvim-comment'
    use {'folke/todo-comments.nvim', requires = "nvim-lua/plenary.nvim"}
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- Utilities
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'

    use 'petertriho/nvim-scrollbar'

    use {"iamcco/markdown-preview.nvim", run = "cd app && npm install"}

    use 'hiphish/rainbow-delimiters.nvim'

    use 'RRethy/vim-illuminate'

    use 'ahmedkhalf/project.nvim'

    use 'johnfrankmorgan/whitespace.nvim'

    use 'levouh/tint.nvim'

    use 'folke/which-key.nvim'

    if PACKER_BOOTSTRAP then require("packer").sync() end
end)

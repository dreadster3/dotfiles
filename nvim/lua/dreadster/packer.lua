-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Plugin Manager
    use 'wbthomason/packer.nvim'

	-- Theme
	use { "catppuccin/nvim", as = "catppuccin" }

	-- Lsp
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
	use 'onsails/lspkind-nvim'
	use { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" }
	use 'folke/neodev.nvim'

	-- DAP
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" }
	use {"jay-babu/mason-nvim-dap.nvim", requires = {"mfussenegger/nvim-dap", "williamboman/mason.nvim"}}

	-- Formatting
	use 'jose-elias-alvarez/null-ls.nvim'

	-- Fuzzy finder
	use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = {{'nvim-lua/plenary.nvim'}} }
	use { 'nvim-telescope/telescope-media-files.nvim', requires = {{ 'nvim-lua/popup.nvim'}} }

	-- Syntax Highlight
	use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
	use 'lewis6991/gitsigns.nvim'

	-- Git
	use 'kdheepak/lazygit.nvim'

	use {
	  'nvim-tree/nvim-tree.lua',
	  requires = {
		'nvim-tree/nvim-web-devicons', -- optional, for file icons
	  }
	}

	-- Notifications
	use 'rcarriga/nvim-notify'
	use 'j-hui/fidget.nvim'

	-- Terminal
	use {"akinsho/toggleterm.nvim", tag = '*'}

	-- Image Handling
	use {
		'samodostal/image.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
	}

	-- File Explorer
	use 'kevinhwang91/rnvimr'

	-- Automations
	use { 'dreadster3/neovim-tasks', requires = "nvim-lua/plenary.nvim" }
	use 'glepnir/template.nvim'

	-- Utilities
	use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	use {
		'goolord/alpha-nvim',
		config = function ()
			require'alpha'.setup(require'alpha.themes.dashboard'.config)
		end
	}

	use 'windwp/nvim-autopairs'
	use 'windwp/nvim-ts-autotag'

	use 'terrortylor/nvim-comment'

	use {'folke/todo-comments.nvim', requires = "nvim-lua/plenary.nvim"}
	use 'petertriho/nvim-scrollbar'

	use { "iamcco/markdown-preview.nvim", run = "cd app && npm install"}

	use "github/copilot.vim"
	
	-- Rust tools
	use 'simrat39/rust-tools.nvim'
end)

